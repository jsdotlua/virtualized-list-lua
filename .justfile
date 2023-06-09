analyze: install-packages
    rojo sourcemap dev.project.json --output sourcemap.json
    curl -O https://raw.githubusercontent.com/JohnnyMorganz/luau-lsp/main/scripts/globalTypes.d.lua
    luau-lsp analyze --definitions=globalTypes.d.lua --base-luaurc=.luaurc --sourcemap=sourcemap.json src/

# Installs packages and proxies their type information with `wally-package-types` tool
# In addition, the packages/ directory is temporarily renamed so that it isn't removed by Wally
install-packages:
    wally install

    rojo sourcemap dev.project.json --output sourcemap.json
    wally-package-types --sourcemap sourcemap.json Packages/

    echo "{\"languageMode\": \"nonstrict\"}" > Packages/.luaurc
