;;; +tree-sitter.el -*- lexical-binding: t; -*-

(use-package! tree-sitter
  :hook (((rustic-mode
           python-mode
           typescript-mode
           css-mode) . tree-sitter-mode)
         ((rustic-mode
           python-mode
           typescript-mode
           css-mode) . tree-sitter-hl-mode)))

;; run `tree-sitter-langs-install-grammars' to install the grammar files for
;;     languages for tree-sitter
;; Also, make sure `tree-sitter'is installed in your system
(use-package tree-sitter-langs
  :if (executable-find "tree-sitter")
  :after tree-sitter)
