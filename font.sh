#!/bin/bash
set -e

FONTS="fonts"
mkdir -p $FONTS

wget -P $FONTS -nc 'https://raw.githubusercontent.com/saifulapm/my-fonts/main/DankMono%20Nerd%20Font/DankMonoNerdFont-Regular.otf'
wget -P $FONTS -nc 'https://raw.githubusercontent.com/saifulapm/my-fonts/main/DankMono%20Nerd%20Font/DankMonoNerdFont-Bold.otf'
wget -P $FONTS -nc 'https://raw.githubusercontent.com/saifulapm/my-fonts/main/DankMono%20Nerd%20Font/DankMonoNerdFont-Italic.otf'

wget -P $FONTS -nc 'https://raw.githubusercontent.com/googlefonts/spacemono/main/fonts/otf/SpaceMono-Regular.otf'
wget -P $FONTS -nc 'https://raw.githubusercontent.com/googlefonts/spacemono/main/fonts/otf/SpaceMono-Bold.otf'
wget -P $FONTS -nc 'https://raw.githubusercontent.com/googlefonts/spacemono/main/fonts/otf/SpaceMono-Italic.otf'
wget -P $FONTS -nc 'https://raw.githubusercontent.com/googlefonts/spacemono/main/fonts/otf/SpaceMono-BoldItalic.otf'

wget -P $FONTS -nc 'https://raw.githubusercontent.com/ryanoasis/nerd-fonts/v3.4.0/patched-fonts/JetBrainsMono/Ligatures/Regular/JetBrainsMonoNerdFont-Regular.ttf'
wget -P $FONTS -nc 'https://raw.githubusercontent.com/ryanoasis/nerd-fonts/v3.4.0/patched-fonts/JetBrainsMono/Ligatures/Italic/JetBrainsMonoNerdFont-Italic.ttf'
wget -P $FONTS -nc 'https://raw.githubusercontent.com/ryanoasis/nerd-fonts/v3.4.0/patched-fonts/JetBrainsMono/Ligatures/ExtraBold/JetBrainsMonoNerdFont-ExtraBold.ttf'
wget -P $FONTS -nc 'https://raw.githubusercontent.com/ryanoasis/nerd-fonts/v3.4.0/patched-fonts/JetBrainsMono/Ligatures/ExtraBoldItalic/JetBrainsMonoNerdFont-ExtraBoldItalic.ttf'

wget -P $FONTS -nc 'https://raw.githubusercontent.com/ryanoasis/nerd-fonts/v3.4.0/patched-fonts/Hasklig/Regular/HasklugNerdFont-Regular.otf'
wget -P $FONTS -nc 'https://raw.githubusercontent.com/ryanoasis/nerd-fonts/v3.4.0/patched-fonts/Hasklig/Italic/HasklugNerdFont-Italic.otf'
wget -P $FONTS -nc 'https://raw.githubusercontent.com/ryanoasis/nerd-fonts/v3.4.0/patched-fonts/Hasklig/Bold/HasklugNerdFont-Bold.otf'
wget -P $FONTS -nc 'https://raw.githubusercontent.com/ryanoasis/nerd-fonts/v3.4.0/patched-fonts/Hasklig/Bold-Italic/HasklugNerdFont-BoldItalic.otf'

wget -P $FONTS -nc 'https://raw.githubusercontent.com/ryanoasis/nerd-fonts/v3.4.0/patched-fonts/FiraCode/Retina/FiraCodeNerdFont-Retina.ttf'
wget -P $FONTS -nc 'https://raw.githubusercontent.com/ryanoasis/nerd-fonts/v3.4.0/patched-fonts/FiraCode/Bold/FiraCodeNerdFont-Bold.ttf'
wget -P $FONTS -nc 'https://raw.githubusercontent.com/ryanoasis/nerd-fonts/v3.4.0/patched-fonts/FiraCode/SemiBold/FiraCodeNerdFont-SemiBold.ttf'

wget -P $FONTS -nc 'https://raw.githubusercontent.com/arrowtype/recursive/v1.085/fonts/ArrowType-Recursive-1.085/Recursive_Code/RecMonoDuotone/RecMonoDuotone-Regular-1.085.ttf'
wget -P $FONTS -nc 'https://raw.githubusercontent.com/arrowtype/recursive/v1.085/fonts/ArrowType-Recursive-1.085/Recursive_Code/RecMonoDuotone/RecMonoDuotone-Bold-1.085.ttf'
wget -P $FONTS -nc 'https://raw.githubusercontent.com/arrowtype/recursive/v1.085/fonts/ArrowType-Recursive-1.085/Recursive_Code/RecMonoDuotone/RecMonoDuotone-Italic-1.085.ttf'
wget -P $FONTS -nc 'https://raw.githubusercontent.com/arrowtype/recursive/v1.085/fonts/ArrowType-Recursive-1.085/Recursive_Code/RecMonoDuotone/RecMonoDuotone-BoldItalic-1.085.ttf'

wget -P $FONTS -nc 'https://raw.githubusercontent.com/shaunsingh/SFMono-Nerd-Font-Ligaturized/main/LigaSFMonoNerdFont-Regular.otf'
wget -P $FONTS -nc 'https://raw.githubusercontent.com/shaunsingh/SFMono-Nerd-Font-Ligaturized/main/LigaSFMonoNerdFont-RegularItalic.otf'
wget -P $FONTS -nc 'https://raw.githubusercontent.com/shaunsingh/SFMono-Nerd-Font-Ligaturized/main/LigaSFMonoNerdFont-Bold.otf'
wget -P $FONTS -nc 'https://raw.githubusercontent.com/shaunsingh/SFMono-Nerd-Font-Ligaturized/main/LigaSFMonoNerdFont-BoldItalic.otf'

wget -P $FONTS -nc 'https://raw.githubusercontent.com/googlefonts/dm-mono/main/exports/DMMono-Regular.ttf'
wget -P $FONTS -nc 'https://raw.githubusercontent.com/googlefonts/dm-mono/main/exports/DMMono-Italic.ttf'
wget -P $FONTS -nc 'https://raw.githubusercontent.com/googlefonts/dm-mono/main/exports/DMMono-Medium.ttf'
wget -P $FONTS -nc 'https://raw.githubusercontent.com/googlefonts/dm-mono/main/exports/DMMono-MediumItalic.ttf'

wget -P $FONTS -nc 'https://raw.githubusercontent.com/intel/intel-one-mono/V1.4.0/fonts/otf/IntelOneMono-Regular.otf'
wget -P $FONTS -nc 'https://raw.githubusercontent.com/intel/intel-one-mono/V1.4.0/fonts/otf/IntelOneMono-Bold.otf'
wget -P $FONTS -nc 'https://raw.githubusercontent.com/intel/intel-one-mono/V1.4.0/fonts/otf/IntelOneMono-Italic.otf'
wget -P $FONTS -nc 'https://raw.githubusercontent.com/intel/intel-one-mono/V1.4.0/fonts/otf/IntelOneMono-BoldItalic.otf'

wget -P $FONTS -nc 'https://raw.githubusercontent.com/g5becks/Cartograph/main/CartographCF-Regular.otf'
wget -P $FONTS -nc 'https://raw.githubusercontent.com/g5becks/Cartograph/main/CartographCF-RegularItalic.otf'
wget -P $FONTS -nc 'https://raw.githubusercontent.com/g5becks/Cartograph/main/CartographCF-Bold.otf'
wget -P $FONTS -nc 'https://raw.githubusercontent.com/g5becks/Cartograph/main/CartographCF-BoldItalic.otf'

if [ ! -f $FONTS/zed-mono-extendedmedium.ttf ]; then
	wget -P $FONTS -nc 'https://github.com/zed-industries/zed-fonts/releases/download/1.2.0/zed-mono-1.2.0.zip'
	cd $FONTS
	unzip 'zed-mono-1.2.0.zip'
	mv zed-mono-extendedmedium.ttf backup-1.ttf
	mv zed-mono-extendeditalic.ttf backup-2.ttf
	mv zed-mono-extendedextrabold.ttf backup-3.ttf
	mv zed-mono-extendedextrabolditalic.ttf backup-4.ttf
	rm zed-mono-*
	mv backup-1.ttf zed-mono-extendedmedium.ttf
	mv backup-2.ttf zed-mono-extendeditalic.ttf
	mv backup-3.ttf zed-mono-extendedextrabold.ttf
	mv backup-4.ttf zed-mono-extendedextrabolditalic.ttf
fi

if [ ! -f $FONTS/IoskeleyMonoNerdFont-Regular.ttf ]; then
	wget -P $FONTS -nc 'https://github.com/ahatem/IoskeleyMono/releases/download/v2.0.0/IoskeleyMono-NerdFont.zip'
	cd $FONTS
	unzip 'IoskeleyMono-NerdFont.zip'
	mv Normal/IoskeleyMonoNerdFont-Regular.ttf .
	mv Normal/IoskeleyMonoNerdFont-Italic.ttf .
	mv Normal/IoskeleyMonoNerdFont-Bold.ttf .
	mv Normal/IoskeleyMonoNerdFont-BoldItalic.ttf .
	rm -rf 'IoskeleyMono-NerdFont.zip' 'Condensed/' 'Normal/' 'SemiCondensed/'
fi
