{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    ruby_3_3
    bundler
    git
    gcc
    zlib
    libyaml
    libxml2
    libxslt
    nodejs
  ];

  shellHook = ''
    export GEM_HOME=$PWD/.gems
    export PATH=$GEM_HOME/bin:$PATH
    export BUNDLE_PATH=$GEM_HOME

    echo "Bananews Newsletter — Jekyll dev shell"
    echo ""
    echo "Quick start:"
    echo "  bundle install"
    echo "  bundle exec jekyll serve --livereload"
    echo ""
    echo "Gems installed locally in .gems/ (gitignored)"
  '';
}
