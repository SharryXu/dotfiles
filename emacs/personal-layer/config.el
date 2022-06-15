;;; package --- Summary

;;; Commentary:

;;; Code:
(defvar sharry-docset-collection '("Go" "C" "Python_3" "Bootstrap_4"))

(defvar sharry-async-shell-buffer-name "Async Shell Command")

(defvar sharry-chicken-repl-buffer-name "Chicken REPL")

(defvar sharry-default-clang-format-config-file-path "~/.clang-format")

(defvar sharry-default-diredful-config-file-path "~/.diredful-conf.el")

(defvar sharry-local-hexo-server-default-address "http://localhost:4000")

(defvar sharry-default-clang-format-style
	"{
     BasedOnStyle: LLVM,
     IndentWidth: 4,
     BreakBeforeBraces: Allman,
     AllowShortFunctionsOnASingleLine: false
  }"
	"Default Style. If no .clang-format file can be found.")

(defvar sharry-code-style-for-c
	'((indent-tabs-mode . nil)
		(c-basic-offset . 4)
		(tab-width . 4)
		(c-comment-only-line-offset . 0)
		(c-hanging-braces-alist . ((substatement-open before after)
															 (brace-list-open after)))
		(c-offsets-alist . ((statement-block-intro . +)
												(substatement-open . 0)
												(substatement-label . 0)
												(label . 0)
												(statement-cont . +)
												(innamespace . 0)
												(inline-open . 0)))
		(c-hanging-braces-alist . ((brace-list-open)
															 (brace-list-intro)
															 (brace-list-entry)
															 (brace-list-close)
															 (brace-entry-open)
															 (block-close . c-snug-do-while)
															 ;; structs have hanging braces on open
															 (class-open . (after))
															 ;; ditto if statements
															 (substatement-open . (after))
															 ;; and no auto newline at the end
															 (class-close)))))

(provide 'config)

;;; config.el ends here
