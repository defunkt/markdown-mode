;;; ikiwiki-mode.el --- Emacs mode for Ikiwiki

;; Copyright (C) 2012 Matthias Ihrke <ihrke@nld.ds.mpg.de>

;; Author: Matthias Ihrke <ihrke@nld.ds.mpg.de>
;; Maintainer: Matthias Ihrke <ihrke@nld.ds.mpg.de>
;; Created: 
;; Version: 0.1
;; Keywords: Markdown, ikiwiki
;; URL: 

;; This file is not part of GNU Emacs.

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program; if not, write to the Free Software
;; Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

(require 'markdown-mode)

;;; Constants =================================================================

(defconst ikiwiki-mode-version "0.1"
  "Ikiwiki mode version number.")

;;; Customizable variables ====================================================

(defgroup ikiwiki nil
  "Major mode for editing ikiwiki files in Markdown format."
  :prefix "ikiwiki-"
  :group 'wp
  :link '(url-link "http://ihrke.github.com/markdown-mode/"))

(defcustom ikiwiki-toplevel nil
  "Path to main ikiwiki-directory."
  :group 'ikiwiki
  :type 'string)

(defcustom ikiwiki-executable "ikiwiki"
  "Path to ikiwiki-executable."
  :group 'ikiwiki
  :type 'string)

(defcustom ikiwiki-setup-file nil
  "Path to setup file for your ikiwiki (required for previewing)."
  :group 'ikiwiki
  :type 'string)

(defcustom ikiwiki-browse-extensions '("mdwn" "markdown")
  "Extension used for ikiwiki files when browsing the wiki."
  :group 'ikiwiki
  :type 'list)

;;; Font lock =================================================================

(defvar markdown-ikiwiki-directive-face 'markdown-ikiwiki-directive-face
  "Face name to use for ikiwiki-directives.")

(defface markdown-ikiwiki-directive-face
  '((t (:inherit font-lock-warning-face :weight normal)))
  "Face for ikiwiki-directives."
  :group 'markdown-faces)

(defconst markdown-regex-wiki-link-ikiwiki
  "\\[\\[\\([^!][^]|]+\\)\\(|\\([^]]+\\)\\)?\\]\\]"
  "Regular expression for matching wiki links.
Similar to `markdown-regex-wiki-link' except, that 
links beginning with '!' are not matched (because
these are ikiwiki-directives.")

(defconst markdown-regex-ikiwiki-directive
  "\\[\\[![^]]+?\\]\\]"
  "Regular expression for matching ikiwiki directives of the form
[[!command param1='test']].")

(defconst markdown-mode-font-lock-keywords-ikiwiki
  (list
   ;; directive [[!command ]]
   (cons markdown-regex-ikiwiki-directive
			'markdown-ikiwiki-directive-face))
  "Syntax highlighting for Ikiwiki-specific statements.")

;;; Menu ==================================================================

(easy-menu-define ikiwiki-mode-menu markdown-mode-map
  "Menu for Ikiwiki mode"
  '("Ikiwiki" 
	 ["Render" ikiwiki-preview]))

;;; Commands ==================================================================

(defun ikiwiki-preview ()
  "Render the current buffer with ikiwiki in a special buffer and browse with web browser."
  (interactive)
  
  (let ((output-buffer-name "*IkiwikiRendered*"))
	 (if ikiwiki-setup-file
		  (progn 
			 (shell-command (concat ikiwiki-executable " --setup " 
											ikiwiki-setup-file " --render "
											(shell-quote-argument buffer-file-name))
								 output-buffer-name)
			 (browse-url-of-buffer output-buffer-name))
		(message "Error: need ikiwiki-setup-file"))))

(defun kill-current-buffer()
  "Kills the current buffer."
  (interactive)
  (kill-buffer nil))

;;; Wiki-Browser ==================================================================

(defun ikiwiki-browse-wiki-at-point ()
  ""
  (interactive)
  (let ((where (thing-at-point 'line)))
	 (message "Where: %s" where)
	 (kill-buffer "*IkiwikiBrowser*")
													 ;(delete-region 0 (buffer-size))
	 (ikiwiki-browse-wiki (concat (file-name-as-directory ikiwiki-toplevel) where))
	 )
)

(defun ikiwiki-browse-wiki (&optional browsepath)
  "Browse the structure of `ikiwiki-toplevel' directory. All
files having an extension in `ikiwiki-browse-extensions' are
displayed in the buffer."
  (interactive)
  (let* ( (path (if browsepath browsepath ikiwiki-toplevel)) 
			 (browserbuf (get-buffer-create "*IkiwikiBrowser*"))
			 (fileregexp (concat ".+\\.\\(" (mapconcat 'identity ikiwiki-browse-extensions "\\|") "\\\)$"))
			(files (directory-files path nil fileregexp t)) 
			)
	 (message "Browsing at path: %s" path)
    (save-excursion
      (set-buffer browserbuf)
		(insert (concat fileregexp "\n"))
		(dolist (curf files)
		  (let ( (start (point))
					(f (file-name-sans-extension curf)))
			 (insert (concat f "\n"))
			 (if (file-exists-p (concat (file-name-as-directory path) f))
				  (put-text-property start (point) 'face 'markdown-bold-face)
				(put-text-property start (point) 'face 'markdown-link-face)
				)
		  ))
      (setq buffer-read-only t)
		(local-set-key "q" 'kill-current-buffer)
		(local-set-key "\C-m" 'ikiwiki-browse-wiki-at-point)
    )
    (switch-to-buffer browserbuf)))


;; examples
;(directory-files "." t (concat ".+\\(" (mapconcat 'identity '("mdwn" "text" "markdown") "\\|") "\\)$"))
;(directory-files "." t ".+\\(mdwn\\|text\\|markdown\\)$")


