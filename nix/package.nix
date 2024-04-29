{
  pkgs,
  lib,
  inputs,
  neovim-unwrapped,
  config ? {
    theme = "rose-pine";
    transparentBackground = false;
  },
}:
with lib; let
  # Parse the boolean into its vim boolean string value.
  transparentBackgroundStr =
    if config.transparentBackground
    then "true"
    else "false";

  # Use this to create a plugin from a flake input
  mkNvimPlugin = src: pname:
    pkgs.vimUtils.buildVimPlugin {
      inherit pname src;
      version = src.lastModifiedDate;
    };

  # This is the helper function that builds the Neovim derivation.
  mkNeovim = pkgs.callPackage ./mkNeovim.nix {};

  all-plugins = with pkgs.vimPlugins; [
    # Completers.
    nvim-cmp
    cmp-calc
    cmp-nvim-lsp
    cmp-path
    cmp-rg
    cmp_luasnip
    (mkNvimPlugin inputs.gitmoji-nvim "gitmoji-nvim")

    # Formatters.
    conform-nvim

    # Gits.
    gitsigns-nvim
    vim-fugitive

    # LSPs.
    nvim-lspconfig
    fidget-nvim
    lsp_signature-nvim
    neodev-nvim
    outline-nvim

    # Miscs.
    copilot-lua
    dial-nvim
    nvim-autopairs
    nvim-spider
    todo-comments-nvim
    toggleterm-nvim
    (mkNvimPlugin inputs.nvim-puppeteer "nvim-puppeteer")
    (mkNvimPlugin inputs.nvim-rooter "nvim-rooter")
    (mkNvimPlugin inputs.vim-characterize "vim-characterize")
    (mkNvimPlugin inputs.vim-kitty "vim-kitty")

    # Minizinc.
    (mkNvimPlugin inputs.vim-minizinc "vim-minizinc")

    # Mini plugins.
    mini-nvim

    # Snippets.
    luasnip

    # Telescope.
    telescope-nvim
    telescope-fzf-native-nvim
    (mkNvimPlugin inputs.telescope-helpgrep-nvim "telescope-helpgrep-nvim")

    # Tex.
    vimtex
    (mkNvimPlugin inputs.cmp-vimtex "cmp-vimtex")

    # Themes.
    catppuccin-nvim
    gruvbox-nvim
    kanagawa-nvim
    rose-pine
    (mkNvimPlugin inputs.everforest-nvim "everforest-nvim")

    # Tree.
    nvim-tree-lua

    # Treesitter.
    nvim-treesitter.withAllGrammars
    nvim-treesitter-context
    nvim-treesitter-refactor
    nvim-treesitter-textobjects
    hmts-nvim

    # UI.
    alpha-nvim
    dressing-nvim
    lualine-nvim
    which-key-nvim

    # General dependencies.
    nvim-web-devicons
    plenary-nvim
  ];

  # Extra packages for your plugins. I decided not to provide LSPs and other
  # formatters, but you can add theme here.
  #
  # See this debate for more: https://www.reddit.com/r/NixOS/comments/18oai2a/should_lsp_servers_be_in_the_project_flake/
  extraPackages = with pkgs; [
    nodePackages_latest.nodejs
    ripgrep
    # lua-language-server
  ];

  extraLuaPackages = ps:
    with ps; [
    ];
in {
  # This is the neovim derivation returned by the overlay.
  nvim-pkg = mkNeovim {
    inherit neovim-unwrapped;
    plugins = all-plugins;
    inherit extraPackages;
    inherit extraLuaPackages;
    extraLuaConfig = ''
      -- Global theme of the config. The UI plugins use this to set the theme.
      vim.g.theme = "${config.theme}"

      -- Whether to use a transparent background or not.
      vim.g.transparent_background = ${transparentBackgroundStr}
    '';
  };

  # This can be symlinked in the devShell's shellHook.
  nvim-luarc-json = mk-luarc-json {
    nvim = pkgs.neovim-nightly;
    plugins = all-plugins;
    neodev-types = "nightly";
  };
}
