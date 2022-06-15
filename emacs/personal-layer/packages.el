;;; packages.el --- sharry layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2018 Sylvain Benner & Contributors
;;
;; Author: Sharry R Xu <sharry.r.xu@gmail.com>
;; URL: https://github.com/SharryXu/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Commentary:

;;; Code:
(defvar sharry-packages
  '(
    ;; Based on the changelog in master branch,
    ;; this package has some issues in some terminals.
    evil-terminal-cursor-changer
    osx-clipboard
    all-the-icons-dired
    diredful
    ac-geiser
    evil-smartparens
    diff-hl
    hexo
    evil-multiedit
		exec-path-from-shell
		elisp-format
		vue-mode
    ))

(defun sharry/init-evil-terminal-cursor-changer ()
	"Init package."
  (use-package evil-terminal-cursor-changer
    :defer t
    :config
    ;; evil-normal-state-cursor
    ;; evil-insert-state-cursor
    ;; evil-visual-state-cursor
    ;; evil-motion-state-cursor
    ;; evil-replace-state-cursor
    ;; evil-operator-state-cursor
    (setq evil-insert-state-cursor '((bar . 8) "blue")
          evil-normal-state-cursor '(box "blue"))
    :init
    (unless (window-system)
      (evil-terminal-cursor-changer-activate))))

(defun sharry/init-osx-clipboard ()
	"Init package."
  (use-package osx-clipboard
    :defer t
    :init
    (require 'core-funcs)
    (when (spacemacs/system-is-mac)
      (osx-clipboard-mode))))

(defun sharry/init-all-the-icons-dired ()
	"Init package."
  (use-package all-the-icons-dired))

(defun sharry/init-ac-geiser ()
	"Init package."
  (use-package ac-geiser
    :defer t))

(defun sharry/init-evil-smartparens ()
	"Init package."
  (use-package evil-smartparens
    :init
    (require 'smartparens)
    (add-hook 'smartparens-enabled-hook #'evil-smartparens-mode)))

(defun sharry/init-diff-hl ()
	"Init package."
  (use-package diff-hl
    :defer t))

(defun sharry/init-hexo ()
	"Init package."
  (use-package hexo
    :defer t))

(defun sharry/init-evil-multiedit ()
	"Init package."
  (use-package evil-multiedit
    :defer t
    :config
    (evil-multiedit-default-keybinds)))

(defun sharry/init-diredful ()
	"Init package."
  (use-package diredful))

(defun sharry/init-exec-path-from-shell ()
	"Init package."
	(use-package exec-path-from-shell
		:defer t))

(defun sharry/init-elisp-format ()
	"Init package."
	(use-package elisp-format
		:defer t))

(defun sharry/init-vue-mode ()
	"Init package."
	(use-package vue-mode
		:defer t))

(provide 'packages)

;;; packages.el ends here
