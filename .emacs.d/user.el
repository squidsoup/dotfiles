;; This is where your customizations should live

;; env PATH
(defun set-exec-path-from-shell-PATH ()
  (let ((path-from-shell (shell-command-to-string "$SHELL -i -c 'echo $PATH'")))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))

(defun add-to-mode (mode lst)
  (dolist (file lst)
    (add-to-list 'auto-mode-alist
                 (cons file mode))))

;; Uncomment the lines below by removing semicolons and play with the
;; values in order to set the width (in characters wide) and height
;; (in lines high) Emacs will have whenever you start it

;; (setq initial-frame-alist '((top . 0) (left . 0) (width . 20) (height . 20)))


;; Place downloaded elisp files in this directory. You'll then be able
;; to load them.
;;
;; For example, if you download yaml-mode.el to ~/.emacs.d/vendor,
;; then you can add the following code to this file:
;;
;; (require 'yaml-mode)
;; (add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
;; 
;; Adding this code will make Emacs enter yaml mode whenever you open
;; a .yml file
(add-to-list 'load-path "~/.emacs.d/vendor")
(add-to-list 'load-path "~/.emacs.d/vendor/js3-mode")

;; X
(setq x-select-enable-clipboard t)

;; shell scripts
(setq-default sh-basic-offset 2)
(setq-default sh-indentation 2)

;; Misc
;;(require 'buffer-move)
(setq require-final-newline t)
;; nginx
;;(require 'nginx-mode)

;; Themes
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(add-to-list 'load-path "~/.emacs.d/themes")
;; Uncomment this to increase font size
;;(set-face-attribute 'default nil :height 100)
(load-theme 'solarized-dark t)

;; ido
(setq ido-use-filename-at-point nil)
(setq ido-ignore-extensions t)

;; Flyspell often slows down editing so it's turned off
(remove-hook 'text-mode-hook 'turn-on-flyspell)

;; Modeline
(setq frame-title-format
      (list (format "%s %%S: %%j " (system-name))
            '(buffer-file-name "%f" (dired-directory dired-directory "%b"))))

;; Flycheck
(require 'flycheck)
(require 'flycheck-color-mode-line)

(add-hook 'after-init-hook #'global-flycheck-mode)
(eval-after-load "flycheck"
  '(add-hook 'flycheck-mode-hook 'flycheck-color-mode-line-mode))

;; customize flycheck temp file prefix
(setq-default flycheck-temp-prefix ".flycheck")


;; Global programming
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
(add-hook 'after-init-hook 'global-company-mode)

;; HTML
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-hook 'html-mode-hook 'turn-off-auto-fill)

;; adjust indents for web-mode to 2 spaces
(defun my-web-mode-hook ()
  "Hooks for Web mode. Adjust indents"
  ;;; http://web-mode.org/
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2))
(add-hook 'web-mode-hook 'my-web-mode-hook)


;; JavaScript
(require 'js3-mode)
(add-to-list 'auto-mode-alist '("\\.js$" . js3-mode))

'(js3-auto-indent-p t)         ; it's nice for commas to right themselves.
'(js3-enter-indents-newline t) ; don't need to push tab before typing
'(js3-indent-on-enter-key t)   ; fix indenting before moving on

;; disable jshint since we prefer eslint checking
(setq-default flycheck-disabled-checkers
  (append flycheck-disabled-checkers
          '(javascript-jshint)))

;; disable json-jsonlist checking for json files
(setq-default flycheck-disabled-checkers
  (append flycheck-disabled-checkers
          '(json-jsonlist)))


;; JSX
;; use web-mode for .jsx files
(add-to-list 'auto-mode-alist '("\\.jsx$" . web-mode))
;; use eslint with web-mode for jsx files
(flycheck-add-mode 'javascript-eslint 'web-mode)

;; for better jsx syntax-highlighting in web-mode
;; - courtesy of Patrick @halbtuerke
(defadvice web-mode-highlight-part (around tweak-jsx activate)
  (if (equal web-mode-content-type "jsx")
    (let ((web-mode-enable-part-face nil))
      ad-do-it)
    ad-do-it))


;; Clojure
(add-to-mode 'clojure-mode (list
                            "\\.edn$"
                            "\\.cljs$"))
(setq clojure-defun-style-default-indent t)

;; Cider
(add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)
(add-hook 'cider-repl-mode-hook 'rainbow-delimiters-mode)


;; Golang
(add-to-list 'load-path "~/.emacs.d/vendor/go-mode.el/")
(require 'go-mode-autoloads)
;; Python
;;(add-hook 'python-mode-hook 'auto-complete-mode)
;;(add-hook 'python-mode-hook 'jedi:setup)
(add-hook 'python-mode-hook 'anaconda-mode)
(add-hook 'python-mode-hook 'whitespace-mode)
(add-to-list 'auto-mode-alist '("\\.tac$" . python-mode))
; Don't edit python bytecode
(add-to-list 'completion-ignored-extensions ".pyc")



;; Zope templates
(add-to-mode 'nxml-mode (list
                         "\\.pt$"
                         "\\.zcml$"
                         "\\.xhtml$"))

;; Sass

; disable electric indent for this mode, as it doesn't appear to work
; very well
(add-hook 'sass-mode-hook (lambda () (electric-indent-local-mode -1)))

; rebind return to newline-and-indent
(add-hook 'sass-mode-hook 
          (lambda () (local-set-key (kbd "C-j") #'newline-and-indent)))

(add-hook 'sass-mode-hook 
          (lambda () (local-set-key (kbd "C-m") #'newline-and-indent)))

(defconst sass-line-keywords
  '(("@\\(\\w+\\)"    0 font-lock-keyword-face sass-highlight-directive)
    ("/[/*].*"  0 font-lock-comment-face)
    ("[=+]\\w+" 0 font-lock-variable-name-face sass-highlight-script-after-match)
    ("!\\w+"    0 font-lock-variable-name-face sass-highlight-script-after-match)
    (":\\w+"    0 font-lock-variable-name-face)
    ("\\w+\s*:" 0 font-lock-variable-name-face)
    ("\\(\\w+\\)\s*="  1 font-lock-variable-name-face sass-highlight-script-after-match)
    ("\\(:\\w+\\)\s*=" 1 font-lock-variable-name-face sass-highlight-script-after-match)
    (".*"      sass-highlight-selector)))

(defconst sass-selector-font-lock-keywords
  '( ;; Attribute selectors (e.g. p[foo=bar])
    ("\\[\\([^]=]+\\)" (1 font-lock-variable-name-face)
     ("[~|$^*]?=\\([^]=]+\\)" nil nil (1 font-lock-string-face)))
    ("&"       0 font-lock-constant-face)
    ("\\.\\w+" 0 font-lock-type-face)
    ("#\\w+"   0 font-lock-keyword-face)
    ;; Pseudo-selectors, optionally with arguments (e.g. :first, :nth-child(12))
    ("\\(::?\\w+\\)" (1 font-lock-variable-name-face)
     ("(\\([^)]+\\))" nil nil (1 font-lock-string-face)))))

(defconst sass-non-block-openers
  '("^.*,$" ;; Continued selectors
    "^ *@\\(extend\\|debug\\|warn\\|include\\|import\\)" ;; Single-line mixins
    "^ *[$!]"     ;; Variables
    ".*[^\s-]+: [^\s-]" ;; a setting of some sort
    ))

;; Haskell
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)

;; Rust
(add-to-list 'auto-mode-alist '("\\.rs$" . rust-mode))

;; Markdown
(add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))
(add-hook 'markdown-mode-hook (lambda ()
                                (setq visual-line-mode t)))
(add-hook 'markdown-mode-hook 'turn-off-auto-fill)

;; hippie expand - don't try to complete with file names
(setq hippie-expand-try-functions-list (delete 'try-complete-file-name hippie-expand-try-functions-list))
(setq hippie-expand-try-functions-list (delete 'try-complete-file-name-partially hippie-expand-try-functions-list))

;; create the autosave dir if necessary, since emacs won't.
(defvar custom-autosaves-dir "~/.emacs.d/autosaves/")
(make-directory custom-autosaves-dir t)
(setq auto-save-directory custom-autosaves-dir)

