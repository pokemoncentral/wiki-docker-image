FROM mediawiki:1.39.4-fpm

ENV MEDIAWIKI_BRANCH=REL1_39 \
    COMPOSER_NO_DEV=1 \
    COMPOSER_NO_INTERACTION=1

# SVG resizing dependency
RUN apt update \
    && apt install -y librsvg2-dev

RUN curl -sSL https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions -o - | sh -s \
    exif \
    gettext \
    gd \
    imagick \
    luasandbox \
    redis \
    @composer

RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini" \
    && echo 'memory_limit = 256M' >> /usr/local/etc/php/conf.d/docker-php-memlimit.ini

WORKDIR /var/www/html/extensions

# Remove default extensions
RUN rm -rf *

RUN git clone --depth 1 -b $MEDIAWIKI_BRANCH https://github.com/wikimedia/mediawiki-extensions-AdvancedSearch.git AdvancedSearch \
    && git clone --depth 1 -b $MEDIAWIKI_BRANCH https://github.com/wikimedia/mediawiki-extensions-BetaFeatures.git BetaFeatures \
    && git clone --depth 1 -b $MEDIAWIKI_BRANCH https://github.com/wikimedia/mediawiki-extensions-Capiunto.git Capiunto \
    && git clone --depth 1 -b $MEDIAWIKI_BRANCH https://github.com/wikimedia/mediawiki-extensions-CategoryTree.git CategoryTree \
    && git clone --depth 1 -b $MEDIAWIKI_BRANCH https://github.com/wikimedia/mediawiki-extensions-CharInsert.git CharInsert \
    && git clone --depth 1 -b $MEDIAWIKI_BRANCH https://github.com/wikimedia/mediawiki-extensions-CheckUser.git CheckUser \
    && git clone --depth 1 -b $MEDIAWIKI_BRANCH https://github.com/wikimedia/mediawiki-extensions-CirrusSearch.git CirrusSearch \
    && git clone --depth 1 -b $MEDIAWIKI_BRANCH https://github.com/wikimedia/mediawiki-extensions-Cite.git Cite \
    && git clone --depth 1 -b $MEDIAWIKI_BRANCH https://github.com/wikimedia/mediawiki-extensions-CiteThisPage.git CiteThisPage \
    && git clone --depth 1 -b $MEDIAWIKI_BRANCH https://github.com/wikimedia/mediawiki-extensions-CodeEditor.git CodeEditor \
    && git clone --depth 1 -b $MEDIAWIKI_BRANCH https://github.com/wikimedia/mediawiki-extensions-CodeMirror.git CodeMirror \
    && git clone --depth 1 -b $MEDIAWIKI_BRANCH https://github.com/wikimedia/mediawiki-extensions-ConfirmEdit.git ConfirmEdit \
    && git clone --depth 1 -b $MEDIAWIKI_BRANCH https://github.com/wikimedia/mediawiki-extensions-Disambiguator.git Disambiguator \
    && git clone --depth 1 -b $MEDIAWIKI_BRANCH https://github.com/wikimedia/mediawiki-extensions-DiscussionTools.git DiscussionTools \
    && git clone --depth 1 -b $MEDIAWIKI_BRANCH https://github.com/wikimedia/mediawiki-extensions-Echo.git Echo \
    && git clone --depth 1 -b $MEDIAWIKI_BRANCH https://github.com/wikimedia/mediawiki-extensions-Elastica.git Elastica \
    # && git clone --depth 1 -b $MEDIAWIKI_BRANCH https://github.com/wikimedia/mediawiki-extensions-FlexboxStyles.git FlexboxStyles \
    && git clone --depth 1 -b $MEDIAWIKI_BRANCH https://github.com/wikimedia/mediawiki-extensions-Gadgets.git Gadgets \
    # && git clone --depth 1 -b $MEDIAWIKI_BRANCH https://github.com/wikimedia/mediawiki-extensions-GoogleRichCards.git GoogleRichCards \
    && git clone --depth 1 -b $MEDIAWIKI_BRANCH https://github.com/wikimedia/mediawiki-extensions-ImageMap.git ImageMap \
    && git clone --depth 1 -b $MEDIAWIKI_BRANCH https://github.com/wikimedia/mediawiki-extensions-InputBox.git InputBox \
    && git clone --depth 1 -b $MEDIAWIKI_BRANCH https://github.com/wikimedia/mediawiki-extensions-Interwiki.git Interwiki \
    && git clone --depth 1 -b $MEDIAWIKI_BRANCH https://github.com/wikimedia/mediawiki-extensions-LocalisationUpdate.git LocalisationUpdate \
    && git clone --depth 1 -b $MEDIAWIKI_BRANCH https://github.com/wikimedia/mediawiki-extensions-Linter.git Linter \
    && git clone --depth 1 -b $MEDIAWIKI_BRANCH https://github.com/wikimedia/mediawiki-extensions-Math.git Math \
    && git clone --depth 1 -b $MEDIAWIKI_BRANCH https://github.com/wikimedia/mediawiki-extensions-MobileFrontend.git MobileFrontend \
    && git clone --depth 1 -b $MEDIAWIKI_BRANCH https://github.com/wikimedia/mediawiki-extensions-MultimediaViewer.git MultimediaViewer \
    && git clone --depth 1 -b $MEDIAWIKI_BRANCH https://github.com/wikimedia/mediawiki-extensions-Nuke.git Nuke \
    && git clone --depth 1 -b $MEDIAWIKI_BRANCH https://github.com/wikimedia/mediawiki-extensions-OATHAuth.git OATHAuth \
    && git clone --depth 1 -b $MEDIAWIKI_BRANCH https://github.com/wikimedia/mediawiki-extensions-PageImages.git PageImages \
    && git clone --depth 1 -b $MEDIAWIKI_BRANCH https://github.com/wikimedia/mediawiki-extensions-ParserFunctions.git ParserFunctions \
    && git clone --depth 1 -b $MEDIAWIKI_BRANCH https://github.com/wikimedia/mediawiki-extensions-PdfHandler.git PdfHandler \
    && git clone --depth 1 -b $MEDIAWIKI_BRANCH https://github.com/wikimedia/mediawiki-extensions-Poem.git Poem \
    && git clone --depth 1 -b $MEDIAWIKI_BRANCH https://github.com/wikimedia/mediawiki-extensions-Popups.git Popups \
    && git clone --depth 1 -b $MEDIAWIKI_BRANCH https://github.com/wikimedia/mediawiki-extensions-RelatedArticles.git RelatedArticles \
    && git clone --depth 1 -b $MEDIAWIKI_BRANCH https://github.com/wikimedia/mediawiki-extensions-Renameuser.git Renameuser \
    && git clone --depth 1 -b $MEDIAWIKI_BRANCH https://github.com/wikimedia/mediawiki-extensions-ReplaceText.git ReplaceText \
    && git clone --depth 1 -b $MEDIAWIKI_BRANCH https://github.com/wikimedia/mediawiki-extensions-RevisionSlider.git RevisionSlider \
    && git clone --depth 1 -b $MEDIAWIKI_BRANCH https://github.com/wikimedia/mediawiki-extensions-SandboxLink.git SandboxLink \
    && git clone --depth 1 -b $MEDIAWIKI_BRANCH https://github.com/wikimedia/mediawiki-extensions-Scribunto.git Scribunto \
    && git clone --depth 1 -b $MEDIAWIKI_BRANCH https://github.com/wikimedia/mediawiki-extensions-SecureLinkFixer.git SecureLinkFixer \
    && git clone --depth 1 -b $MEDIAWIKI_BRANCH https://github.com/wikimedia/mediawiki-extensions-SpamBlacklist.git SpamBlacklist \
    && git clone --depth 1 -b $MEDIAWIKI_BRANCH https://github.com/wikimedia/mediawiki-extensions-SyntaxHighlight_GeSHi.git SyntaxHighlight_GeSHi \
    && git clone --depth 1 -b $MEDIAWIKI_BRANCH https://github.com/wikimedia/mediawiki-extensions-TemplateData.git TemplateData \
    && git clone --depth 1 -b $MEDIAWIKI_BRANCH https://github.com/wikimedia/mediawiki-extensions-TemplateSandbox.git TemplateSandbox \
    && git clone --depth 1 -b $MEDIAWIKI_BRANCH https://github.com/wikimedia/mediawiki-extensions-TextExtracts.git TextExtracts \
    && git clone --depth 1 -b $MEDIAWIKI_BRANCH https://github.com/wikimedia/mediawiki-extensions-Thanks.git Thanks \
    && git clone --depth 1 -b $MEDIAWIKI_BRANCH https://github.com/wikimedia/mediawiki-extensions-TitleBlacklist.git TitleBlacklist \
    && git clone --depth 1 -b $MEDIAWIKI_BRANCH https://github.com/wikimedia/mediawiki-extensions-TitleKey.git TitleKey \
    && git clone --depth 1 -b $MEDIAWIKI_BRANCH https://github.com/wikimedia/mediawiki-extensions-TwitterCards.git TwitterCards \
    && git clone --depth 1 -b $MEDIAWIKI_BRANCH https://github.com/wikimedia/mediawiki-extensions-UserMerge.git UserMerge \
    && git clone --depth 1 -b $MEDIAWIKI_BRANCH https://github.com/wikimedia/mediawiki-extensions-VipsScaler.git VipsScaler \
    && git clone --depth 1 --recurse-submodules --shallow-submodules -b $MEDIAWIKI_BRANCH https://github.com/wikimedia/mediawiki-extensions-VisualEditor.git VisualEditor \
    && git clone --depth 1 -b $MEDIAWIKI_BRANCH https://github.com/wikimedia/mediawiki-extensions-Widgets.git Widgets \
    && git clone --depth 1 -b $MEDIAWIKI_BRANCH https://github.com/wikimedia/mediawiki-extensions-WikiEditor.git WikiEditor \
    # non-mediawiki stuff
    && git clone --depth 1 https://github.com/edwardspec/mediawiki-aws-s3.git AWS

RUN chown -R www-data:www-data .

WORKDIR /var/www/html

RUN mv composer.local.json-sample composer.local.json \
    && composer update

CMD ["php-fpm"]
