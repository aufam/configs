function setwallpaper --description "Set Windows wallpaper from WSL (Fish)"
    # usage
    if test (count $argv) -lt 1
        echo "Usage: setwallpaper <image-path> [fill|fit|stretch|center|tile|span]"
        return 2
    end

    # WSL check
    if not uname -r | string match -q "*microsoft*"
        echo "This function is intended for WSL (Windows Subsystem for Linux)."
        return 1
    end

    set img (realpath -- $argv[1])
    if not test -f $img
        echo "File not found: $img"
        return 3
    end

    # style mapping (Windows registry expects these numbers)
    set style "fill"
    switch $style
        case fill
            set WPSTYLE 10; set TILE 0
        case fit
            set WPSTYLE 6; set TILE 0
        case stretch
            set WPSTYLE 2; set TILE 0
        case center
            set WPSTYLE 0; set TILE 0
        case tile
            set WPSTYLE 0; set TILE 1
        case span
            set WPSTYLE 22; set TILE 0
        case '*'
            echo "Unknown style: $style (use: fill|fit|stretch|center|tile|span)"
            return 4

    end

    # convert to Windows path
    set winpath (wslpath -w -- $img)

    # call into PowerShell to update registry + broadcast change
    powershell.exe -NoProfile -NonInteractive -Command "
    \$path = '$winpath';
    if (-not (Test-Path -LiteralPath \$path)) { Write-Error 'File not found on Windows: ' + \$path; exit 1 }
    Set-ItemProperty -Path 'HKCU:\Control Panel\Desktop' -Name WallpaperStyle -Value $WPSTYLE | Out-Null

    Set-ItemProperty -Path 'HKCU:\Control Panel\Desktop' -Name TileWallpaper   -Value $TILE     | Out-Null
    Add-Type -TypeDefinition @\"
using System.Runtime.InteropServices;

public class Native {
  [DllImport(\"user32.dll\", SetLastError=true, CharSet=System.Runtime.InteropServices.CharSet.Auto)]
  public static extern bool SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
}
\"@;
    # 20 = SPI_SETDESKWALLPAPER, 0x1|0x2 = update INI + broadcast change
    [Native]::SystemParametersInfo(20, 0, \$path, 0x1 -bor 0x2) | Out-Null
    "

    if test $status -eq 0
        echo "Wallpaper set to: $img ($style)"
    else
        echo "Failed to set wallpaper."
        return 5
    end
end
