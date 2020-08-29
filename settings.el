;; [[file:~/.emacs.d/settings.org::*require][require:1]]
(setq package-selected-packages
      (quote
       (helm helm-dash eslint-fix magithub powerline-evil rw-ispell web-mode paredit flycheck-clojure flycheck-gradle flycheck-popup-tip flyparens helm-flycheck helm-flyspell paren-completer paren-face projectile cider clojure-mode helm-projectile helm-themes spotify which-key use-package ace-window mu4e-maildirs-extension  evil-tutor  flycheck flyspell-correct-helm magit)))

'(ring-bell-function (quote ignore))

(put 'dired-find-alternate-file 'disabled nil)
;; require:1 ends here

;; [[file:~/.emacs.d/settings.org::*Elegant Theme][Elegant Theme:1]]
;; -------------------------------------------------------------------
;; A very minimal but elegant and consistent theme
;; Copyright 2020 Nicolas P. Rougier
;; -------------------------------------------------------------------
;; This file is not part of GNU Emacs.
;;
;; This program is free software: you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation, either version 3 of the
;; License, or (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program. If not, see <http://www.gnu.org/licenses/>
;; -------------------------------------------------------------------


;; Only necessary for the splash screen mockup
;; -------------------------------------------------------------------
(with-eval-after-load 'org
  (setq org-display-inline-images t)
  (setq org-redisplay-inline-images t)
  (setq org-startup-with-inline-images "inlineimages")
  (setq org-hide-emphasis-markers t)
  (setq org-confirm-elisp-link-function nil)
  (setq org-link-frame-setup '((file . find-file))))
;; -------------------------------------------------------------------


;; Font and frame size
(set-face-font 'default "Roboto Mono Light 12")
(setq default-frame-alist
      (append (list '(width  . 72) '(height . 40)
                    '(vertical-scroll-bars . nil)
                    '(internal-border-width . 24)
                    '(font . "Roboto Mono Light 12"))))
(set-frame-parameter (selected-frame)
                     'internal-border-width 24)

;; Line spacing, can be 0 for code and 1 or 2 for text
(setq-default line-spacing 0)

;; Underline line at descent position, not baseline position
(setq x-underline-at-descent-line t)

;; No ugly button for checkboxes
(setq widget-image-enable nil)

;; Line cursor and no blink
(set-default 'cursor-type  '(bar . 1))
(blink-cursor-mode 0)

;; No sound
(setq visible-bell t)
(setq ring-bell-function 'ignore)

;; No Tooltips
(tooltip-mode 0)

;; Paren mode is part of the theme
(show-paren-mode t)

;; No fringe but nice glyphs for truncated and wrapped lines
(fringe-mode '(0 . 0))
(defface fallback '((t :family "Fira Code Light"
                       :inherit 'face-faded)) "Fallback")
(set-display-table-slot standard-display-table 'truncation
                        (make-glyph-code ?… 'fallback))
(set-display-table-slot standard-display-table 'wrap
                        (make-glyph-code ?↩ 'fallback))
(set-display-table-slot standard-display-table 'selective-display
                        (string-to-vector " …"))


;; When we set a face, we take care of removing any previous settings
(defun set-face (face style)
  "Reset a face and make it inherit style."
  (set-face-attribute face nil
   :foreground 'unspecified :background 'unspecified
   :family     'unspecified :slant      'unspecified
   :weight     'unspecified :height     'unspecified
   :underline  'unspecified :overline   'unspecified
   :box        'unspecified :inherit    style))

;; A theme is fully defined by these six faces 
(defgroup elegance nil
  "Faces for the elegance theme"
  :prefix "face-")

;; Do not show prefix when displaying the elegance group
(setq custom-unlispify-remove-prefixes t)

(defface face-critical nil
"Critical face is for information that requires immediate action.
It should be of high constrast when compared to other faces. This
can be realized (for example) by setting an intense background
color, typically a shade of red. It must be used scarcely."
:group 'elegance)

(defface face-popout nil
"Popout face is used for information that needs attention.
To achieve such effect, the hue of the face has to be
sufficiently different from other faces such that it attracts
attention through the popout effect."
:group 'elegance)

(defface face-strong nil
"Strong face is used for information of a structural nature.
It has to be the same color as the default color and only the
weight differs by one level (e.g., light/regular or
regular/bold). IT is generally used for titles, keywords,
directory, etc."
:group 'elegance)

(defface face-salient nil
"Salient face is used for information that are important.
To suggest the information is of the same nature but important,
the face uses a different hue with approximately the same
intensity as the default face. This is typically used for links."

:group 'elegance)

(defface face-faded nil
"Faded face is for information that are less important.
It is made by using the same hue as the default but with a lesser
intensity than the default. It can be used for comments,
secondary information and also replace italic (which is generally
abused anyway)."
:group 'elegance)

(defface face-subtle nil
"Subtle face is used to suggest a physical area on the screen.
It is important to not disturb too strongly the reading of
information and this can be made by setting a very light
background color that is barely perceptible."
:group 'elegance)


;; Mode line (this might be slow because of the "☰" that requires substitution)
;; This line below makes things a bit faster
(set-fontset-font "fontset-default"  '(#x2600 . #x26ff) "Fira Code 16")

(define-key mode-line-major-mode-keymap [header-line]
  (lookup-key mode-line-major-mode-keymap [mode-line]))

(defun mode-line-render (left right)
  (let* ((available-width (- (window-width) (length left) )))
    (format (format "%%s %%%ds" available-width) left right)))
(setq-default mode-line-format
     '((:eval
       (mode-line-render
       (format-mode-line (list
         (propertize "☰" 'face `(:inherit mode-line-buffer-id)
                         'help-echo "Mode(s) menu"
                         'mouse-face 'mode-line-highlight
                         'local-map   mode-line-major-mode-keymap)
         " %b "
         (if (and buffer-file-name (buffer-modified-p))
             (propertize "(modified)" 'face `(:inherit face-faded)))))
       (format-mode-line
        (propertize "%4l:%2c  " 'face `(:inherit face-faded)))))))


;; Comment if you want to keep the modeline at the bottom
(setq-default header-line-format mode-line-format)
(setq-default mode-line-format'(""))


;; Vertical window divider
(setq window-divider-default-right-width 3)
(setq window-divider-default-places 'right-only)
(window-divider-mode)

;; Modeline
(defun set-modeline-faces ()

  ;; Mode line at top
  (set-face 'header-line                                 'face-strong)
  (set-face-attribute 'header-line nil
                                :underline (face-foreground 'default))
  (set-face-attribute 'mode-line nil
                      :height 10
                      :underline (face-foreground 'default)
                      :overline nil
                      :box nil 
                      :foreground (face-background 'default)
                      :background (face-background 'default))
  (set-face 'mode-line-inactive                            'mode-line)

  ;; Mode line at bottom
  ;; (set-face 'header-line                                 'face-strong)
  ;; (set-face-attribute 'mode-line nil
  ;;                     :height 1.0
  ;;                     :overline (face-background 'default)
  ;;                     :underline nil
  ;;                     :foreground (face-foreground 'default)
  ;;                     :background (face-background 'face-subtle)
  ;;                     :box `(:line-width 2
  ;;                            :color ,(face-background 'face-subtle)
  ;;                            :style nil))
  ;; (set-face 'mode-line-highlight '(face-popout mode-line))
  ;; (set-face 'mode-line-emphasis  'face-strong)
  ;; (set-face-attribute 'mode-line-buffer-id nil :weight 'regular)
  ;; (set-face-attribute 'mode-line-inactive nil
  ;;                     :height 1.0
  ;;                     :overline (face-background 'default)
  ;;                     :underline nil
  ;;                     :foreground (face-foreground 'face-faded)
  ;;                     :background (face-background 'face-subtle)
  ;;                     :box `(:line-width 2 
  ;;                            :color ,(face-background 'face-subtle)
  ;;                            :style nil))


  (set-face-attribute 'cursor nil
                      :background (face-foreground 'default))
  (set-face-attribute 'window-divider nil
                      :foreground (face-background 'mode-line))
  (set-face-attribute 'window-divider-first-pixel nil
                      :foreground (face-background 'default))
  (set-face-attribute 'window-divider-last-pixel nil 
                      :foreground (face-background 'default))
  )

;; Buttons
(defun set-button-faces ()
  (set-face-attribute 'custom-button nil
                      :foreground (face-foreground 'face-faded)
                      :background (face-background 'face-subtle)
                      :box `(:line-width 1
                             :color ,(face-foreground 'face-faded)
                             :style nil))
  (set-face-attribute 'custom-button-mouse nil
                      :foreground (face-foreground 'default)
                      ;; :background (face-foreground 'face-faded)
                      :inherit 'custom-button
                      :box `(:line-width 1
                             :color ,(face-foreground 'face-subtle)
                             :style nil))
  (set-face-attribute 'custom-button-pressed nil
                      :foreground (face-background 'default)
                      :background (face-foreground 'face-salient)
                      :inherit 'face-salient
                      :box `(:line-width 1
                             :color ,(face-foreground 'face-salient)
                             :style nil)
                      :inverse-video nil))

;; Light theme 
(defun elegance-light ()
    (setq frame-background-mode 'light)
    (set-background-color "#ffffff")
    (set-foreground-color "#333333")
    (set-face-attribute 'default nil
                        :foreground (face-foreground 'default)
                        :background (face-background 'default))
    (set-face-attribute 'face-critical nil :foreground "#ffffff"
                                           :background "#ff6347")
    (set-face-attribute 'face-popout nil :foreground "#ffa07a")
    (set-face-attribute 'face-strong nil :foreground "#333333"
                                         :weight 'regular)
    (set-face-attribute 'face-salient nil :foreground "#00008b"
                                          :weight 'light)
    (set-face-attribute 'face-faded nil :foreground "#999999"
                                        :weight 'light)
    (set-face-attribute 'face-subtle nil :background "#f0f0f0")

    (set-modeline-faces)

    (with-eval-after-load 'cus-edit (set-button-faces)))

;; Dark theme
(defun elegance-dark ()
    (setq frame-background-mode 'dark)
    (set-background-color "#3f3f3f")
    (set-foreground-color "#dcdccc")
    (set-face-attribute 'default nil
                        :foreground (face-foreground 'default)
                        :background (face-background 'default))
    (set-face-attribute 'face-critical nil :foreground "#385f38"
                                           :background "#f8f893")
    (set-face-attribute 'face-popout nil :foreground "#f0dfaf")
    (set-face-attribute 'face-strong nil :foreground "#dcdccc"
                                         :weight 'regular)
    (set-face-attribute 'face-salient nil :foreground "#dca3a3"
                                          :weight 'light)
    (set-face-attribute 'face-faded nil :foreground "#929285"
                                        :weight 'light)
    (set-face-attribute 'face-subtle nil :background "#4f4f4f")
    (set-modeline-faces)
    (with-eval-after-load 'cus-edit (set-button-faces)))

;; Set theme
(elegance-dark)

;; Structural
(set-face 'bold                                          'face-strong)
(set-face 'italic                                         'face-faded)
(set-face 'bold-italic                                   'face-strong)
(set-face 'region                                        'face-subtle)
(set-face 'highlight                                     'face-subtle)
(set-face 'fixed-pitch                                       'default)
(set-face 'fixed-pitch-serif                                 'default)
(set-face 'variable-pitch                                    'default)
(set-face 'cursor                                            'default)

;; Semantic
(set-face 'shadow                                         'face-faded)
(set-face 'success                                      'face-salient)
(set-face 'warning                                       'face-popout)
(set-face 'error                                       'face-critical)

;; General
(set-face 'buffer-menu-buffer                            'face-strong)
(set-face 'minibuffer-prompt                             'face-strong)
(set-face 'link                                         'face-salient)
(set-face 'fringe                                         'face-faded)
(set-face 'isearch                                       'face-strong)
(set-face 'isearch-fail                                   'face-faded)
(set-face 'lazy-highlight                                'face-subtle)
(set-face 'trailing-whitespace                           'face-subtle)
(set-face 'show-paren-match                              'face-popout)
(set-face 'show-paren-mismatch                           'face-normal)
(set-face-attribute 'tooltip nil                         :height 0.85)

;; Programmation mode
(set-face 'font-lock-comment-face                         'face-faded)
(set-face 'font-lock-doc-face                             'face-faded)
(set-face 'font-lock-string-face                         'face-popout)
(set-face 'font-lock-constant-face                      'face-salient)
(set-face 'font-lock-warning-face                        'face-popout)
(set-face 'font-lock-function-name-face                  'face-strong)
(set-face 'font-lock-variable-name-face                  'face-strong)
(set-face 'font-lock-builtin-face                       'face-salient)
(set-face 'font-lock-type-face                          'face-salient)
(set-face 'font-lock-keyword-face                       'face-salient)

;; Documentation
(with-eval-after-load 'info
  (set-face 'info-menu-header                            'face-strong)
  (set-face 'info-header-node                            'face-normal)
  (set-face 'Info-quoted                                  'face-faded)
  (set-face 'info-title-1                                'face-strong)
  (set-face 'info-title-2                                'face-strong)
  (set-face 'info-title-3                                'face-strong)
  (set-face 'info-title-4                               'face-strong))

;; Bookmarks
(with-eval-after-load 'bookmark
  (set-face 'bookmark-menu-heading                       'face-strong)
  (set-face 'bookmark-menu-bookmark                    'face-salient))

;; Message
(with-eval-after-load 'message
  (set-face 'message-cited-text                           'face-faded)
  (set-face 'message-header-cc                               'default)
  (set-face 'message-header-name                         'face-strong)
  (set-face 'message-header-newsgroups                       'default)
  (set-face 'message-header-other                            'default)
  (set-face 'message-header-subject                     'face-salient)
  (set-face 'message-header-to                          'face-salient)
  (set-face 'message-header-xheader                          'default)
  (set-face 'message-mml                                 'face-popout)
  (set-face 'message-separator                           'face-faded))

;; Outline
(with-eval-after-load 'outline
  (set-face 'outline-1                                   'face-strong)
  (set-face 'outline-2                                   'face-strong)
  (set-face 'outline-3                                   'face-strong)
  (set-face 'outline-4                                   'face-strong)
  (set-face 'outline-5                                   'face-strong)
  (set-face 'outline-6                                   'face-strong)
  (set-face 'outline-7                                   'face-strong)
  (set-face 'outline-8                                  'face-strong))

;; Interface
(with-eval-after-load 'cus-edit
  (set-face 'widget-field                                'face-subtle)
  (set-face 'widget-button                               'face-strong)
  (set-face 'widget-single-line-field                    'face-subtle)
  (set-face 'custom-group-subtitle                       'face-strong)
  (set-face 'custom-group-tag                            'face-strong)
  (set-face 'custom-group-tag-1                          'face-strong)
  (set-face 'custom-comment                               'face-faded)
  (set-face 'custom-comment-tag                           'face-faded)
  (set-face 'custom-changed                             'face-salient)
  (set-face 'custom-modified                            'face-salient)
  (set-face 'custom-face-tag                             'face-strong)
  (set-face 'custom-variable-tag                             'default)
  (set-face 'custom-invalid                              'face-popout)
  (set-face 'custom-visibility                          'face-salient)
  (set-face 'custom-state                               'face-salient)
  (set-face 'custom-link                               'face-salient))

;; Package
(with-eval-after-load 'package
  (set-face 'package-description                             'default)
  (set-face 'package-help-section-name                       'default)
  (set-face 'package-name                               'face-salient)
  (set-face 'package-status-avail-obso                    'face-faded)
  (set-face 'package-status-available                        'default)
  (set-face 'package-status-built-in                    'face-salient)
  (set-face 'package-status-dependency                  'face-salient)
  (set-face 'package-status-disabled                      'face-faded)
  (set-face 'package-status-external                         'default)
  (set-face 'package-status-held                             'default)
  (set-face 'package-status-incompat                      'face-faded)
  (set-face 'package-status-installed                   'face-salient)
  (set-face 'package-status-new                              'default)
  (set-face 'package-status-unsigned                         'default)

  ;; Button face is hardcoded, we have to redefine the relevant
  ;; function
  (defun package-make-button (text &rest properties)
    "Insert button labeled TEXT with button PROPERTIES at point.
PROPERTIES are passed to `insert-text-button', for which this
function is a convenience wrapper used by `describe-package-1'."
    (let ((button-text (if (display-graphic-p)
                           text (concat "[" text "]")))
          (button-face (if (display-graphic-p)
                           '(:box `(:line-width 1
                             :color "#999999":style nil)
                            :foreground "#999999"
                            :background "#F0F0F0")
                         'link)))
      (apply #'insert-text-button button-text
             'face button-face 'follow-link t properties)))
  )

;; Flyspell
(with-eval-after-load 'flyspell
  (set-face 'flyspell-duplicate                         'face-popout)
  (set-face 'flyspell-incorrect                         'face-popout))

;; Ido 
(with-eval-after-load 'ido
  (set-face 'ido-first-match                            'face-salient)
  (set-face 'ido-only-match                               'face-faded)
  (set-face 'ido-subdir                                 'face-strong))

;; Diff
(with-eval-after-load 'diff-mode
  (set-face 'diff-header                                  'face-faded)
  (set-face 'diff-file-header                            'face-strong)
  (set-face 'diff-context                                    'default)
  (set-face 'diff-removed                                 'face-faded)
  (set-face 'diff-changed                                'face-popout)
  (set-face 'diff-added                                 'face-salient)
  (set-face 'diff-refine-added            '(face-salient face-strong))
  (set-face 'diff-refine-changed                         'face-popout)
  (set-face 'diff-refine-removed                          'face-faded)
  (set-face-attribute     'diff-refine-removed nil :strike-through t))

;; Term
(with-eval-after-load 'term
  ;; (setq eterm-256color-disable-bold nil)
  (set-face 'term-bold                                   'face-strong)
  (set-face-attribute 'term-color-black nil
                                :foreground (face-foreground 'default)
                               :background (face-foreground 'default))
  (set-face-attribute 'term-color-white nil
                              :foreground "white" :background "white")
  (set-face-attribute 'term-color-blue nil
                          :foreground "#42A5F5" :background "#BBDEFB")
  (set-face-attribute 'term-color-cyan nil
                          :foreground "#26C6DA" :background "#B2EBF2")
  (set-face-attribute 'term-color-green nil
                          :foreground "#66BB6A" :background "#C8E6C9")
  (set-face-attribute 'term-color-magenta nil
                          :foreground "#AB47BC" :background "#E1BEE7")
  (set-face-attribute 'term-color-red nil
                          :foreground "#EF5350" :background "#FFCDD2")
  (set-face-attribute 'term-color-yellow nil
                         :foreground "#FFEE58" :background "#FFF9C4"))

;; org-agende
(with-eval-after-load 'org-agenda
  (set-face 'org-agenda-calendar-event                    'default)
  (set-face 'org-agenda-calendar-sexp                     'face-faded)
  (set-face 'org-agenda-clocking                          'face-faded)
  (set-face 'org-agenda-column-dateline                   'face-faded)
  (set-face 'org-agenda-current-time                      'face-faded)
  (set-face 'org-agenda-date                            'face-salient)
  (set-face 'org-agenda-date-today        '(face-salient face-strong))
  (set-face 'org-agenda-date-weekend                      'face-faded)
  (set-face 'org-agenda-diary                             'face-faded)
  (set-face 'org-agenda-dimmed-todo-face                  'face-faded)
  (set-face 'org-agenda-done                              'face-faded)
  (set-face 'org-agenda-filter-category                   'face-faded)
  (set-face 'org-agenda-filter-effort                     'face-faded)
  (set-face 'org-agenda-filter-regexp                     'face-faded)
  (set-face 'org-agenda-filter-tags                       'face-faded)
  ;; (set-face 'org-agenda-property-face                     'face-faded)
  (set-face 'org-agenda-restriction-lock                  'face-faded)
  (set-face 'org-agenda-structure                        'face-faded))

;; org mode
(with-eval-after-load 'org
  (set-face 'org-archived                                 'face-faded)
  (set-face 'org-block                                    'face-faded)
  (set-face 'org-block-begin-line                         'face-faded)
  (set-face 'org-block-end-line                           'face-faded)
  (set-face 'org-checkbox                                 'face-faded)
  (set-face 'org-checkbox-statistics-done                 'face-faded)
  (set-face 'org-checkbox-statistics-todo                 'face-faded)
  (set-face 'org-clock-overlay                            'face-faded)
  (set-face 'org-code                                     'face-faded)
  (set-face 'org-column                                   'face-faded)
  (set-face 'org-column-title                             'face-faded)
  (set-face 'org-date                                     'face-faded)
  (set-face 'org-date-selected                            'face-faded)
  (set-face 'org-default                                  'face-faded)
  (set-face 'org-document-info                            'face-faded)
  (set-face 'org-document-info-keyword                    'face-faded)
  (set-face 'org-document-title                           'face-faded)
  (set-face 'org-done                                        'default)
  (set-face 'org-drawer                                   'face-faded)
  (set-face 'org-ellipsis                                 'face-faded)
  (set-face 'org-footnote                                 'face-faded)
  (set-face 'org-formula                                  'face-faded)
  (set-face 'org-headline-done                            'face-faded)
;;  (set-face 'org-hide                                     'face-faded)
;;  (set-face 'org-indent                                   'face-faded)
  (set-face 'org-latex-and-related                        'face-faded)
  (set-face 'org-level-1                                 'face-strong)
  (set-face 'org-level-2                                 'face-strong)
  (set-face 'org-level-3                                 'face-strong)
  (set-face 'org-level-4                                 'face-strong)
  (set-face 'org-level-5                                 'face-strong)
  (set-face 'org-level-6                                 'face-strong)
  (set-face 'org-level-7                                 'face-strong)
  (set-face 'org-level-8                                 'face-strong)
  (set-face 'org-link                                   'face-salient)
  (set-face 'org-list-dt                                  'face-faded)
  (set-face 'org-macro                                    'face-faded)
  (set-face 'org-meta-line                                'face-faded)
  (set-face 'org-mode-line-clock                          'face-faded)
  (set-face 'org-mode-line-clock-overrun                  'face-faded)
  (set-face 'org-priority                                 'face-faded)
  (set-face 'org-property-value                           'face-faded)
  (set-face 'org-quote                                    'face-faded)
  (set-face 'org-scheduled                                'face-faded)
  (set-face 'org-scheduled-previously                     'face-faded)
  (set-face 'org-scheduled-today                          'face-faded)
  (set-face 'org-sexp-date                                'face-faded)
  (set-face 'org-special-keyword                          'face-faded)
  (set-face 'org-table                                    'face-faded)
  (set-face 'org-tag                                      'face-faded)
  (set-face 'org-tag-group                                'face-faded)
  (set-face 'org-target                                   'face-faded)
  (set-face 'org-time-grid                                'face-faded)
  (set-face 'org-todo                                    'face-popout)
  (set-face 'org-upcoming-deadline                        'face-faded)
  (set-face 'org-verbatim                                 'face-faded)
  (set-face 'org-verse                                    'face-faded)
  (set-face 'org-warning                                'face-popout))

;; Mu4e
(with-eval-after-load 'mu4e
  (set-face 'mu4e-attach-number-face                     'face-strong)
  (set-face 'mu4e-cited-1-face                            'face-faded)
  (set-face 'mu4e-cited-2-face                            'face-faded)
  (set-face 'mu4e-cited-3-face                            'face-faded)
  (set-face 'mu4e-cited-4-face                            'face-faded)
  (set-face 'mu4e-cited-5-face                            'face-faded)
  (set-face 'mu4e-cited-6-face                            'face-faded)
  (set-face 'mu4e-cited-7-face                            'face-faded)
  (set-face 'mu4e-compose-header-face                     'face-faded)
  (set-face 'mu4e-compose-separator-face                  'face-faded)
  (set-face 'mu4e-contact-face                          'face-salient)
  (set-face 'mu4e-context-face                            'face-faded)
  (set-face 'mu4e-draft-face                              'face-faded)
  (set-face 'mu4e-flagged-face                            'face-faded)
  (set-face 'mu4e-footer-face                             'face-faded)
  (set-face 'mu4e-forwarded-face                          'face-faded)
  (set-face 'mu4e-header-face                                'default)
  (set-face 'mu4e-header-highlight-face                  'face-subtle)
  (set-face 'mu4e-header-key-face                        'face-strong)
  (set-face 'mu4e-header-marks-face                       'face-faded)
  (set-face 'mu4e-header-title-face                      'face-strong)
  (set-face 'mu4e-header-value-face                          'default)
  (set-face 'mu4e-highlight-face                         'face-popout)
  (set-face 'mu4e-link-face                             'face-salient)
  (set-face 'mu4e-modeline-face                           'face-faded)
  (set-face 'mu4e-moved-face                              'face-faded)
  (set-face 'mu4e-ok-face                                 'face-faded)
  (set-face 'mu4e-region-code                             'face-faded)
  (set-face 'mu4e-replied-face                          'face-salient)
  (set-face 'mu4e-special-header-value-face                  'default)
  (set-face 'mu4e-system-face                             'face-faded)
  (set-face 'mu4e-title-face                             'face-strong)
  (set-face 'mu4e-trashed-face                            'face-faded)
  (set-face 'mu4e-unread-face                            'face-strong)
  (set-face 'mu4e-url-number-face                         'face-faded)
  (set-face 'mu4e-view-body-face                             'default)
  (set-face 'mu4e-warning-face                            'face-faded))

(provide 'elegance)
;; Elegant Theme:1 ends here

;; [[file:~/.emacs.d/settings.org::*Evil Mode][Evil Mode:1]]
(use-package evil
  :ensure t
  :config
  (evil-mode 1)
  (use-package evil-leader
    :ensure t
    :config
    (global-evil-leader-mode))

  (use-package evil-surround
    :ensure t
    :config
    (global-evil-surround-mode))

  (use-package evil-indent-textobject
    :ensure t)
  
  (dolist (mode '(ag-mode
                  flycheck-error-list-mode
                  git-rebase-mode))
    (add-to-list 'evil-emacs-state-modes mode))
)
(add-hook 'occur-mode-hook
          (lambda ()
            (evil-add-hjkl-bindings occur-mode-map 'emacs
              (kbd "/")       'evil-search-forward
              (kbd "n")       'evil-search-next
              (kbd "N")       'evil-search-previous
              (kbd "C-d")     'evil-scroll-down
              (kbd "C-u")     'evil-scroll-up
              (kbd "C-w C-w") 'other-window)))
;; Evil Mode:1 ends here

;; [[file:~/.emacs.d/settings.org::*flyspell][flyspell:1]]
(setq-default ispell-program-name "/usr/local/bin/aspell")
(setq-default ispell-list-command "list")
(add-hook 'org-mode-hook 'flyspell-mode)
;; flyspell:1 ends here

;; [[file:~/.emacs.d/settings.org::*org-Download and web-tools][org-Download and web-tools:1]]
(use-package org-download)
;; Drag-and-drop to `dired`
(add-hook 'dired-mode-hook 'org-download-enable)

(use-package org-web-tools)
;; org-Download and web-tools:1 ends here

;; [[file:~/.emacs.d/settings.org::*interface tweaks][interface tweaks:1]]
(fset 'yes-or-no-p 'y-or-n-p)
(global-set-key (kbd "<f5>") 'revert-buffer)
(helm-mode 1)
(global-set-key "\C-x\C-f" 'helm-find-files)

(global-visual-line-mode t)
(global-display-line-numbers-mode t)
(setq display-line-numbers-type 'relative)
(tool-bar-mode 0)
(evil-mode 1)

(use-package magithub
:requires (magit magit-popup))
(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-x M-g") 'magit-dispatch)

(use-package rainbow-delimiters
:ensure t)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
(when window-system (set-frame-size (selected-frame) 120 60))
;; interface tweaks:1 ends here

;; [[file:~/.emacs.d/settings.org::*Projectile][Projectile:1]]
(use-package projectile 
:ensure t
:config
(projectile-global-mode)
(setq projectile-completion-system 'helm))
(helm-projectile-on)

(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
;; Projectile:1 ends here

;; [[file:~/.emacs.d/settings.org::*buffer movements ace-windows][buffer movements ace-windows:1]]
(defalias 'list-buffers 'ibuffer)
(use-package ace-window
	     :ensure t
	     :init
	     (progn
	       (global-set-key [remap other-window] 'ace-window)
	       (custom-set-faces
	       '(aw-leading-char-face
		 ((t (:inherit ace-jump-face-foreground :height 2.5)))))))

(use-package which-key
  :ensure t
  :config (which-key-mode))


;; Markdown Mode
(autoload 'markdown-mode "markdown-mode.el"
	"Major mode for editing Markdown files" t)
(setq auto0mode-alist
	(cons '("\.md" . markdown-mode) auto-mode-alist))

(package-initialize)
;; buffer movements ace-windows:1 ends here

;; [[file:~/.emacs.d/settings.org::*Org-Mode][Org-Mode:1]]
(setq org-src-tab-acts-natively t)


  ; Enable habit tracking (and a bunch of other modules)
  (setq org-modules (quote (org-bbdb
			    org-bibtex
			    org-crypt
			    org-gnus
			    org-id
			    org-info
			    org-jsinfo
			    org-habit
			    org-inlinetask
			    org-irc
			    org-mew
			    org-mhe
			    org-protocol
			    org-rmail
			    org-vm
			    org-wl
			    org-w3m)))

  ; position the habit graph on the agenda to the right of the default
  (setq org-habit-graph-column 50)

      ;; Custom Key Bindings
      (global-set-key (kbd "<f12>") 'org-agenda)
      (global-set-key (kbd "<f5>") 'bh/org-todo)
      (global-set-key (kbd "<S-f5>") 'bh/widen)
      (global-set-key (kbd "<f7>") 'bh/set-truncate-lines)
      (global-set-key (kbd "<f8>") 'org-cycle-agenda-files)
      (global-set-key (kbd "<f9> <f9>") 'bh/show-org-agenda)
      (global-set-key (kbd "<f9> b") 'bbdb)
      (global-set-key (kbd "<f9> c") 'calendar)
      (global-set-key (kbd "<f9> f") 'boxquote-insert-file)
      (global-set-key (kbd "<f9> g") 'gnus)
      (global-set-key (kbd "<f9> h") 'bh/hide-other)
      (global-set-key (kbd "<f9> n") 'bh/toggle-next-task-display)

      (global-set-key (kbd "<f9> I") 'bh/punch-in)
      (global-set-key (kbd "<f9> O") 'bh/punch-out)

      (global-set-key (kbd "<f9> o") 'bh/make-org-scratch)

      (global-set-key (kbd "<f9> r") 'boxquote-region)
      (global-set-key (kbd "<f9> s") 'bh/switch-to-scratch)

      (global-set-key (kbd "<f9> t") 'bh/insert-inactive-timestamp)
      (global-set-key (kbd "<f9> T") 'bh/toggle-insert-inactive-timestamp)

      (global-set-key (kbd "<f9> v") 'visible-mode)
      (global-set-key (kbd "<f9> l") 'org-toggle-link-display)
      (global-set-key (kbd "<f9> SPC") 'bh/clock-in-last-task)
      (global-set-key (kbd "C-<f9>") 'previous-buffer)
      (global-set-key (kbd "M-<f9>") 'org-toggle-inline-images)
      (global-set-key (kbd "C-x n r") 'narrow-to-region)
      (global-set-key (kbd "C-<f10>") 'next-buffer)
      (global-set-key (kbd "<f11>") 'org-clock-goto)
      (global-set-key (kbd "C-<f11>") 'org-clock-in)
      (global-set-key (kbd "C-s-<f12>") 'bh/save-then-publish)
      (global-set-key (kbd "C-c c") 'org-capture)

      (defun bh/hide-other ()
	(interactive)
	(save-excursion
	  (org-back-to-heading 'invisible-ok)
	  (hide-other)
	  (org-cycle)
	  (org-cycle)
	  (org-cycle)))

      (defun bh/set-truncate-lines ()
	"Toggle value of truncate-lines and refresh window display."
	(interactive)
	(setq truncate-lines (not truncate-lines))
	;; now refresh window display (an idiom from simple.el):
	(save-excursion
	  (set-window-start (selected-window)
			    (window-start (selected-window)))))

      (defun bh/make-org-scratch ()
	(interactive)
	(find-file "/tmp/publish/scratch.org")
	(gnus-make-directory "/tmp/publish"))

      (defun bh/switch-to-scratch ()
	(interactive)
	(switch-to-buffer "*scratch*"))


      ;; Toggle line mode for org-agenda
      (add-hook 'org-agenda-mode-hook
		(lambda ()
		  (visual-line-mode -1)
		  (toggle-truncate-lines 1)))

      ;; Set agenda view columns
      (setq org-agenda-tags-column 80)

	;; Standard key bindings
	(global-set-key "\C-cl" 'org-store-link)
	(global-set-key "\C-ca" 'org-agenda)
	(global-set-key "\C-cb" 'org-iswitchb) 
	(global-set-key "\C-cc" 'org-capture) 
	(global-set-key (kbd "C-c o") 
			(lambda () (interactive) (find-file "~/Nextcloud/org/TODO.org")))
	(setq org-log-done t)
	(setq org-directory "~/Nextcloud/org")
	(setq org-default-notes-file "~/Nextcloud/org/REFILE.org")

      ;; add BBDB for use in phone call capture
      (use-package bbdb)
      (require 'bbdb)
      (require 'bbdb-com)

      (global-set-key (kbd "<f9> p") 'bh/phone-call)

      ;;
      ;; Phone capture template handling with BBDB lookup
      ;; Adapted from code by Gregory J. Grubbs
      (defun bh/phone-call ()
	"Return name and company info for caller from bbdb lookup"
	(interactive)
	(let* (name rec caller)
	  (setq name (completing-read "Who is calling? "
				      (bbdb-hashtable)
				      'bbdb-completion-predicate
				      'confirm))
	  (when (> (length name) 0)
	    ; Something was supplied - look it up in bbdb
	    (setq rec
		  (or (first
		       (or (bbdb-search (bbdb-records) name nil nil)
			   (bbdb-search (bbdb-records) nil name nil)))
		      name)))

	  ; Build the bbdb link if we have a bbdb record, otherwise just return the name
	  (setq caller (cond ((and rec (vectorp rec))
			      (let ((name (bbdb-record-name rec))
				    (company (bbdb-record-company rec)))
				(concat "[[bbdb:"
					name "]["
					name "]]"
					(when company
					  (concat " - " company)))))
			     (rec)
			     (t "NameOfCaller")))
	  (insert caller)))

	;; Capture templates for: TODO tasks, Notes, appointments, phone calls, meetings, and org-protocol
	(setq org-capture-templates
	      (quote (("t" "todo" entry (file "~/Nextcloud/org/REFILE.org")
		       "* TODO %?\n%U\n%a\n" :clock-in t :clock-resume t)
		      ("r" "respond" entry (file "~/Nextcloud/org/REFILE.org")
		       "* NEXT Respond to %:from on %:subject\nSCHEDULED: %t\n%U\n%a\n%x" :clock-in t :clock-resume t :immediate-finish t)
		      ("n" "note" entry (file "~/Nextcloud/org/REFILE.org")
		       "* %? :NOTE:\n%U\n%a\n" :clock-in t :clock-resume t)
		      ("j" "Journal" entry (file+olp+datetree "~/Nextcloud/org/Journal.org")
		       "* %?\n%U\n" :clock-in t :clock-resume t)
		      ("w" "org-protocol" entry (file "~/Nextcloud/org/REFILE.org")
		       "* TODO Review %c\n%U\n" :immediate-finish t)
		      ("m" "Meeting" entry (file "~/Nextcloud/org/REFILE.org")
		       "* MEETING with %? :MEETING:\n%U" :clock-in t :clock-resume t)
		      ("p" "Project" entry (file "~/Nextcloud/org/REFILE.org")
		       (file "~/Nextcloud/org/ProjectTemplate.org") :clock-in t :clock-resume t)
		      ("W" "Weekly Review" entry (file+olp+datetree "~/Nextcloud/org/Journal.org" )
		       (file "~/Nextcloud/org/WeeklyReviewTemplate.org") :clock-in t :clock-resume t)
		      ("h" "Habit" entry (file "~/Nextcloud/org/REFILE.org")
		       "* NEXT %?\n%U\n%a\nSCHEDULED: %(format-time-string \"%<<%Y-%m-%d %a .+1d/3d>>\")\n:PROPERTIES:\n:STYLE: habit\n:REPEAT_TO_STATE: NEXT\n:END:\n"))))

	;; KEYWORDS    
	(setq org-todo-keywords
	      (quote ((sequence "TODO(t)" "PROJECT(p)" "NEXT(n)" "|" "DONE(d)")
		      (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)" "PHONE" "MEETING"))))
	(setq org-todo-keyword-faces
	      (quote (("TODO" 'face-strong)
		      ("PROJECT" 'face-strong)
		      ("NEXT" 'face-strong)
		      ("DONE" 'face-popout)
		      ("WAITING" 'face-salient)
		      ("HOLD" 'face-salient)
		      ("CANCELLED" 'face-salient)
		      ("MEETING" 'face-popout)
		      ("PHONE" 'face-popout))))
	(setq org-todo-state-tags-triggers
	      (quote (("CANCELLED" ("CANCELLED" . t))
		      ("WAITING" ("WAITING" . t))
		      ("HOLD" ("WAITING") ("HOLD" . t))
		      (done ("WAITING") ("HOLD"))
		      ("TODO" ("WAITING") ("CANCELLED") ("HOLD"))
		      ("NEXT" ("WAITING") ("CANCELLED") ("HOLD"))
		      ("DONE" ("WAITING") ("CANCELLED") ("HOLD")))))

	;; Remove empty LOGBOOK drawers on clock out
	(defun bh/remove-empty-drawer-on-clock-out ()
	  (interactive)
	  (save-excursion
	    (beginning-of-line 0)
	    (org-remove-empty-drawer-at (point))))

	(add-hook 'org-clock-out-hook 'bh/remove-empty-drawer-on-clock-out 'append)

	;;;; Refile settings =============================================
	; Targets include this file and any file contributing to the agenda - up to 9 levels deep
	(setq org-refile-targets (quote ((nil :maxlevel . 9)
					 (org-agenda-files :maxlevel . 9))))

	; Use full outline paths for refile targets - we file directly with IDO          (setq org-refile-use-outline-path 'file)

	; Targets complete directly with HELM
	(setq org-outline-path-complete-in-steps nil)

	; Allow refile to create parent tasks with confirmation
	(setq org-refile-allow-creating-parent-nodes (quote confirm))

	; Use the current window for indirect buffer display
	(setq org-indirect-buffer-display 'current-window)

	; Exclude DONE state tasks from refile targets
	(defun bh/verify-refile-target ()
	  "Exclude todo keywords with a done state from refile targets"
	  (not (member (nth 2 (org-heading-components)) org-done-keywords)))

	(setq org-refile-target-verify-function 'bh/verify-refile-target)



	;; == Agenda ====================================================

      ;; To Keep agenda generation quick:
      (setq org-agenda-span 'day)

      ;; Do not dim blocked tasks
      (setq org-agenda-dim-blocked-tasks nil)

      ;; Compact the block agenda view
      (setq org-agenda-compact-blocks t)

;; include diary in agenda views
(setq org-agenda-include-diary t)

      ;; Custom agenda command definitions
      (setq org-agenda-custom-commands
	    (quote (("N" "Notes" tags "NOTE"
		     ((org-agenda-overriding-header "Notes")
		      (org-tags-match-list-sublevels t)))
		    ("h" "Habits" tags-todo "STYLE=\"habit\""
		     ((org-agenda-overriding-header "Habits")
		      (org-agenda-sorting-strategy
		       '(todo-state-down effort-up category-keep))))

		    ("A" "Agenda"
		     ((agenda "" nil)
		      (tags "REFILE-NOTE"
			    ((org-agenda-overriding-header "Tasks to Refile")
			     (org-tags-match-list-sublevels nil)))
                      (tags "REFILE+NOTE"
			    ((org-agenda-overriding-header "Notes to Refile")
			     (org-tags-match-list-sublevels nil)))
		      (tags-todo "-CANCELLED/!"
				 ((org-agenda-overriding-header "Stuck Projects")
				  (org-agenda-skip-function 'bh/skip-non-stuck-projects)
				  (org-agenda-sorting-strategy
				   '(category-keep))))
		      (tags-todo "-HOLD-CANCELLED/!"
				 ((org-agenda-overriding-header "Projects")
				  (org-agenda-skip-function 'bh/skip-non-projects)
				  (org-tags-match-list-sublevels 'indented)
				  (org-agenda-sorting-strategy
				   '(category-keep))))
		      (tags-todo "-CANCELLED/!NEXT"
				 ((org-agenda-overriding-header (concat "Project Next Tasks"
									(if bh/hide-scheduled-and-waiting-next-tasks
									    ""
									  " (including WAITING and SCHEDULED tasks)")))
				  (org-agenda-skip-function 'bh/skip-projects-and-habits-and-single-tasks)
				  (org-tags-match-list-sublevels t)
				  (org-agenda-todo-ignore-scheduled bh/hide-scheduled-and-waiting-next-tasks)
				  (org-agenda-todo-ignore-deadlines bh/hide-scheduled-and-waiting-next-tasks)
				  (org-agenda-todo-ignore-with-date bh/hide-scheduled-and-waiting-next-tasks)
				  (org-agenda-sorting-strategy
				   '(todo-state-down effort-up category-keep))))
		      (tags-todo "-REFILE-CANCELLED-WAITING-HOLD/!"
				 ((org-agenda-overriding-header (concat "Project Subtasks"
									(if bh/hide-scheduled-and-waiting-next-tasks
									    ""
									  " (including WAITING and SCHEDULED tasks)")))
				  (org-agenda-skip-function 'bh/skip-non-project-tasks)
				  (org-agenda-todo-ignore-scheduled bh/hide-scheduled-and-waiting-next-tasks)
				  (org-agenda-todo-ignore-deadlines bh/hide-scheduled-and-waiting-next-tasks)
				  (org-agenda-todo-ignore-with-date bh/hide-scheduled-and-waiting-next-tasks)
				  (org-agenda-sorting-strategy
				   '(category-keep))))
		      (tags-todo "-REFILE-CANCELLED-WAITING-HOLD/!"
				 ((org-agenda-overriding-header (concat "Standalone Tasks"
									(if bh/hide-scheduled-and-waiting-next-tasks
									    ""
									  " (including WAITING and SCHEDULED tasks)")))
				  (org-agenda-skip-function 'bh/skip-project-tasks)
				  (org-agenda-todo-ignore-scheduled bh/hide-scheduled-and-waiting-next-tasks)
				  (org-agenda-todo-ignore-deadlines bh/hide-scheduled-and-waiting-next-tasks)
				  (org-agenda-todo-ignore-with-date bh/hide-scheduled-and-waiting-next-tasks)
				  (org-agenda-sorting-strategy
				   '(category-keep))))
		      (tags-todo "-CANCELLED+WAITING|HOLD/!"
				 ((org-agenda-overriding-header (concat "Waiting and Postponed Tasks"
									(if bh/hide-scheduled-and-waiting-next-tasks
									    ""
									  " (including WAITING and SCHEDULED tasks)")))
				  (org-agenda-skip-function 'bh/skip-non-tasks)
				  (org-tags-match-list-sublevels nil)
				  (org-agenda-todo-ignore-scheduled bh/hide-scheduled-and-waiting-next-tasks)
				  (org-agenda-todo-ignore-deadlines bh/hide-scheduled-and-waiting-next-tasks)))
		      (tags "-REFILE/"
			    ((org-agenda-overriding-header "Tasks to Archive")
			     (org-agenda-skip-function 'bh/skip-non-archivable-tasks)
			     (org-tags-match-list-sublevels nil))))
		     nil))))

      (defun bh/org-auto-exclude-function (tag)
	"Automatic task exclusion in the agenda with / RET"
	(and (cond
	      ((string= tag "hold")
	       t))
	     (concat "-" tag)))

      (setq org-agenda-auto-exclude-function 'bh/org-auto-exclude-function)

      ;; disable default stuck-projects view
      (setq org-stuck-projects (quote ("" nil nil "")))

      ;; Clock Setup =============================
      ;;
      ;; Resume clocking task when emacs is restarted
      (org-clock-persistence-insinuate)
      ;;
      ;; Show lot of clocking history so it's easy to pick items off the C-F11 list
      (setq org-clock-history-length 23)
      ;; Resume clocking task on clock-in if the clock is open
      (setq org-clock-in-resume t)
      ;; Change tasks to NEXT when clocking in
      (setq org-clock-in-switch-to-state 'bh/clock-in-to-next)
      ;; Separate drawers for clocking and logs
      (setq org-drawers (quote ("PROPERTIES" "LOGBOOK")))
      ;; Save clock data and state changes and notes in the LOGBOOK drawer
      (setq org-clock-into-drawer t)
      ;; Sometimes I change tasks I'm clocking quickly - this removes clocked tasks with 0:00 duration
      (setq org-clock-out-remove-zero-time-clocks t)
      ;; Clock out when moving task to a done state
      (setq org-clock-out-when-done t)
      ;; Save the running clock and all clock history when exiting Emacs, load it on startup
      (setq org-clock-persist t)
      ;; Do not prompt to resume an active clock
      (setq org-clock-persist-query-resume nil)
      ;; Enable auto clock resolution for finding open clocks
      (setq org-clock-auto-clock-resolution (quote when-no-clock-is-running))
      ;; Include current clocking task in clock reports
      (setq org-clock-report-include-clocking-task t)

      (setq bh/keep-clock-running nil)

      (defun bh/clock-in-to-next (kw)
	"Switch a task from TODO to NEXT when clocking in.
      Skips capture tasks, projects, and subprojects.
      Switch projects and subprojects from NEXT back to TODO"
	(when (not (and (boundp 'org-capture-mode) org-capture-mode))
	  (cond
	   ((and (member (org-get-todo-state) (list "TODO"))
		 (bh/is-task-p))
	    "NEXT")
	   ((and (member (org-get-todo-state) (list "NEXT"))
		 (bh/is-project-p))
	    "TODO"))))

      (defun bh/find-project-task ()
	"Move point to the parent (project) task if any"
	(save-restriction
	  (widen)
	  (let ((parent-task (save-excursion (org-back-to-heading 'invisible-ok) (point))))
	    (while (org-up-heading-safe)
	      (when (member (nth 2 (org-heading-components)) org-todo-keywords-1)
		(setq parent-task (point))))
	    (goto-char parent-task)
	    parent-task)))

      (defun bh/punch-in (arg)
	"Start continuous clocking and set the default task to the
      selected task.  If no task is selected set the Organization task
      as the default task."
	(interactive "p")
	(setq bh/keep-clock-running t)
	(if (equal major-mode 'org-agenda-mode)
	    ;;
	    ;; We're in the agenda
	    ;;
	    (let* ((marker (org-get-at-bol 'org-hd-marker))
		   (tags (org-with-point-at marker (org-get-tags-at))))
	      (if (and (eq arg 4) tags)
		  (org-agenda-clock-in '(16))
		(bh/clock-in-organization-task-as-default)))
	  ;;
	  ;; We are not in the agenda
	  ;;
	  (save-restriction
	    (widen)
	    ; Find the tags on the current task
	    (if (and (equal major-mode 'org-mode) (not (org-before-first-heading-p)) (eq arg 4))
		(org-clock-in '(16))
	      (bh/clock-in-organization-task-as-default)))))

      (defun bh/punch-out ()
	(interactive)
	(setq bh/keep-clock-running nil)
	(when (org-clock-is-active)
	  (org-clock-out))
	(org-agenda-remove-restriction-lock))

      (defun bh/clock-in-default-task ()
	(save-excursion
	  (org-with-point-at org-clock-default-task
	    (org-clock-in))))

      (defun bh/clock-in-parent-task ()
	"Move point to the parent (project) task if any and clock in"
	(let ((parent-task))
	  (save-excursion
	    (save-restriction
	      (widen)
	      (while (and (not parent-task) (org-up-heading-safe))
		(when (member (nth 2 (org-heading-components)) org-todo-keywords-1)
		  (setq parent-task (point))))
	      (if parent-task
		  (org-with-point-at parent-task
		    (org-clock-in))
		(when bh/keep-clock-running
		  (bh/clock-in-default-task)))))))

      (defvar bh/organization-task-id "eb155a82-92b2-4f25-a3c6-0304591af2f9")

      (defun bh/clock-in-organization-task-as-default ()
	(interactive)
	(org-with-point-at (org-id-find bh/organization-task-id 'marker)
	  (org-clock-in '(16))))

      (defun bh/clock-out-maybe ()
	(when (and bh/keep-clock-running
		   (not org-clock-clocking-in)
		   (marker-buffer org-clock-default-task)
		   (not org-clock-resolving-clocks-due-to-idleness))
	  (bh/clock-in-parent-task)))

      (add-hook 'org-clock-out-hook 'bh/clock-out-maybe 'append)

      (setq org-time-stamp-rounding-minutes (quote (1 1)))

      (setq org-agenda-clock-consistency-checks
	    (quote (:max-duration "4:00"
		    :min-duration 0
		    :max-gap 0
		    :gap-ok-around ("4:00"))))

      ;; Sometimes I change tasks I'm clocking quickly - this removes clocked tasks with 0:00 duration
      (setq org-clock-out-remove-zero-time-clocks t)

      ;; Agenda clock report parameters
      (setq org-agenda-clockreport-parameter-plist
	    (quote (:link t :maxlevel 5 :fileskip0 t :compact t :narrow 80)))

      ; Set default column view headings: Task Effort Clock_Summary
      (setq org-columns-default-format "%80ITEM(Task) %10Effort(Effort){:} %10CLOCKSUM")

      ; global Effort estimate values
      ; global STYLE property values for completion
      (setq org-global-properties (quote (("Effort_ALL" . "0:15 0:30 0:45 1:00 2:00 3:00 4:00 5:00 6:00 0:00")
					  ("STYLE_ALL" . "habit"))))

      ;; Agenda log mode items to display (closed and state changes by default)
      (setq org-agenda-log-mode-items (quote (closed state)))

      ; Tags with fast selection keys
      (setq org-tag-alist (quote ((:startgroup)
				  ("@errand" . ?e)
				  ("@office" . ?o)
				  ("@home" . ?H)
				  (:endgroup)
				  ("PERSONAL" . ?P)
				  ("OLIVER" . ?O)
				  ("NOTE" . ?n)
				  ("CANCELLED" . ?c)
				  ("FLAGGED" . ??))))

      ; Allow setting single tags without the menu
      (setq org-fast-tag-selection-single-key (quote expert))

      ; For tag searches ignore tasks with scheduled and deadline dates
      (setq org-agenda-tags-todo-honor-ignore-options t)

      ;; Agenda Helper Functions =========================

      (defun org-is-habit-p (&optional pom)
	"Is the task at POM or point a habit?"
	 (string= "habit" (org-entry-get (or pom (point)) "STYLE")))

      (defun org-habit-parse-todo (&optional pom))

      (defun bh/is-project-p ()
	"Any PROJECT task with a todo keyword subtask"
	(save-restriction
	  (widen)
	  (let ((has-subtask)
		(subtree-end (save-excursion (org-end-of-subtree t)))
		(is-a-task (member (nth 2 (org-heading-components)) org-todo-keywords-1)))
	    (save-excursion
	      (forward-line 1)
	      (while (and (not has-subtask)
			  (< (point) subtree-end)
			  (re-search-forward "^\*+ " subtree-end t))
		(when (member (org-get-todo-state) org-todo-keywords-1)
		  (setq has-subtask t))))
	    (and is-a-task has-subtask))))

      (defun bh/is-project-subtree-p ()
	"Any task with a todo keyword that is in a project subtree.
      Callers of this function already widen the buffer view."
	(let ((task (save-excursion (org-back-to-heading 'invisible-ok)
				    (point))))
	  (save-excursion
	    (bh/find-project-task)
	    (if (equal (point) task)
		nil
	      t))))

      (defun bh/is-task-p ()
	"Any task with a todo keyword and no subtask"
	(save-restriction
	  (widen)
	  (let ((has-subtask)
		(subtree-end (save-excursion (org-end-of-subtree t)))
		(is-a-task (member (nth 2 (org-heading-components)) org-todo-keywords-1)))
	    (save-excursion
	      (forward-line 1)
	      (while (and (not has-subtask)
			  (< (point) subtree-end)
			  (re-search-forward "^\*+ " subtree-end t))
		(when (member (org-get-todo-state) org-todo-keywords-1)
		  (setq has-subtask t))))
	    (and is-a-task (not has-subtask)))))

      (defun bh/is-subproject-p ()
	"Any task which is a subtask of another project"
	(let ((is-subproject)
	      (is-a-task (member (nth 2 (org-heading-components)) org-todo-keywords-1)))
	  (save-excursion
	    (while (and (not is-subproject) (org-up-heading-safe))
	      (when (member (nth 2 (org-heading-components)) org-todo-keywords-1)
		(setq is-subproject t))))
	  (and is-a-task is-subproject)))

      (defun bh/list-sublevels-for-projects-indented ()
	"Set org-tags-match-list-sublevels so when restricted to a subtree we list all subtasks.
	This is normally used by skipping functions where this variable is already local to the agenda."
	(if (marker-buffer org-agenda-restrict-begin)
	    (setq org-tags-match-list-sublevels 'indented)
	  (setq org-tags-match-list-sublevels nil))
	nil)

      (defun bh/list-sublevels-for-projects ()
	"Set org-tags-match-list-sublevels so when restricted to a subtree we list all subtasks.
	This is normally used by skipping functions where this variable is already local to the agenda."
	(if (marker-buffer org-agenda-restrict-begin)
	    (setq org-tags-match-list-sublevels t)
	  (setq org-tags-match-list-sublevels nil))
	nil)

      (defvar bh/hide-scheduled-and-waiting-next-tasks t)

      (defun bh/toggle-next-task-display ()
	(interactive)
	(setq bh/hide-scheduled-and-waiting-next-tasks (not bh/hide-scheduled-and-waiting-next-tasks))
	(when  (equal major-mode 'org-agenda-mode)
	  (org-agenda-redo))
	(message "%s WAITING and SCHEDULED NEXT Tasks" (if bh/hide-scheduled-and-waiting-next-tasks "Hide" "Show")))

      (defun bh/skip-stuck-projects ()
	"Skip trees that are not stuck projects"
	(save-restriction
	  (widen)
	  (let ((next-headline (save-excursion (or (outline-next-heading) (point-max)))))
	    (if (bh/is-project-p)
		(let* ((subtree-end (save-excursion (org-end-of-subtree t)))
		       (has-next ))
		  (save-excursion
		    (forward-line 1)
		    (while (and (not has-next) (< (point) subtree-end) (re-search-forward "^\\*+ NEXT " subtree-end t))
		      (unless (member "WAITING" (org-get-tags-at))
			(setq has-next t))))
		  (if has-next
		      nil
		    next-headline)) ; a stuck project, has subtasks but no next task
	      nil))))

      (defun bh/skip-non-stuck-projects ()
	"Skip trees that are not stuck projects"
	;; (bh/list-sublevels-for-projects-indented)
	(save-restriction
	  (widen)
	  (let ((next-headline (save-excursion (or (outline-next-heading) (point-max)))))
	    (if (bh/is-project-p)
		(let* ((subtree-end (save-excursion (org-end-of-subtree t)))
		       (has-next ))
		  (save-excursion
		    (forward-line 1)
		    (while (and (not has-next) (< (point) subtree-end) (re-search-forward "^\\*+ NEXT " subtree-end t))
		      (unless (member "WAITING" (org-get-tags-at))
			(setq has-next t))))
		  (if has-next
		      next-headline
		    nil)) ; a stuck project, has subtasks but no next task
	      next-headline))))

      (defun bh/skip-non-projects ()
	"Skip trees that are not projects"
	;; (bh/list-sublevels-for-projects-indented)
	(if (save-excursion (bh/skip-non-stuck-projects))
	    (save-restriction
	      (widen)
	      (let ((subtree-end (save-excursion (org-end-of-subtree t))))
		(cond
		 ((bh/is-project-p)
		  nil)
		 ((and (bh/is-project-subtree-p) (not (bh/is-task-p)))
		  nil)
		 (t
		  subtree-end))))
	  (save-excursion (org-end-of-subtree t))))

      (defun bh/skip-non-tasks ()
	"Show non-project tasks.
      Skip project and sub-project tasks, habits, and project related tasks."
	(save-restriction
	  (widen)
	  (let ((next-headline (save-excursion (or (outline-next-heading) (point-max)))))
	    (cond
	     ((bh/is-task-p)
	      nil)
	     (t
	      next-headline)))))

      (defun bh/skip-project-trees-and-habits ()
	"Skip trees that are projects"
	(save-restriction
	  (widen)
	  (let ((subtree-end (save-excursion (org-end-of-subtree t))))
	    (cond
	     ((bh/is-project-p)
	      subtree-end)
	     ((org-is-habit-p)
	      subtree-end)
	     (t
	      nil)))))

      (defun bh/skip-projects-and-habits-and-single-tasks ()
	"Skip trees that are projects, tasks that are habits, single non-project tasks"
	(save-restriction
	  (widen)
	  (let ((next-headline (save-excursion (or (outline-next-heading) (point-max)))))
	    (cond
	     ((org-is-habit-p)
	      next-headline)
	     ((and bh/hide-scheduled-and-waiting-next-tasks
		   (member "WAITING" (org-get-tags-at)))
	      next-headline)
	     ((bh/is-project-p)
	      next-headline)
	     ((and (bh/is-task-p) (not (bh/is-project-subtree-p)))
	      next-headline)
	     (t
	      nil)))))

      (defun bh/skip-project-tasks-maybe ()
	"Show tasks related to the current restriction.
      When restricted to a project, skip project and sub project tasks, habits, NEXT tasks, and loose tasks.
      When not restricted, skip project and sub-project tasks, habits, and project related tasks."
	(save-restriction
	  (widen)
	  (let* ((subtree-end (save-excursion (org-end-of-subtree t)))
		 (next-headline (save-excursion (or (outline-next-heading) (point-max))))
		 (limit-to-project (marker-buffer org-agenda-restrict-begin)))
	    (cond
	     ((bh/is-project-p)
	      next-headline)
	     ((org-is-habit-p)
	      subtree-end)
	     ((and (not limit-to-project)
		   (bh/is-project-subtree-p))
	      subtree-end)
	     ((and limit-to-project
		   (bh/is-project-subtree-p)
		   (member (org-get-todo-state) (list "NEXT")))
	      subtree-end)
	     (t
	      nil)))))

      (defun bh/skip-project-tasks ()
	"Show non-project tasks.
      Skip project and sub-project tasks, habits, and project related tasks."
	(save-restriction
	  (widen)
	  (let* ((subtree-end (save-excursion (org-end-of-subtree t))))
	    (cond
	     ((bh/is-project-p)
	      subtree-end)
	     ((org-is-habit-p)
	      subtree-end)
	     ((bh/is-project-subtree-p)
	      subtree-end)
	     (t
	      nil)))))

      (defun bh/skip-non-project-tasks ()
	"Show project tasks.
      Skip project and sub-project tasks, habits, and loose non-project tasks."
	(save-restriction
	  (widen)
	  (let* ((subtree-end (save-excursion (org-end-of-subtree t)))
		 (next-headline (save-excursion (or (outline-next-heading) (point-max)))))
	    (cond
	     ((bh/is-project-p)
	      next-headline)
	     ((org-is-habit-p)
	      subtree-end)
	     ((and (bh/is-project-subtree-p)
		   (member (org-get-todo-state) (list "NEXT")))
	      subtree-end)
	     ((not (bh/is-project-subtree-p))
	      subtree-end)
	     (t
	      nil)))))

      (defun bh/skip-projects-and-habits ()
	"Skip trees that are projects and tasks that are habits"
	(save-restriction
	  (widen)
	  (let ((subtree-end (save-excursion (org-end-of-subtree t))))
	    (cond
	     ((bh/is-project-p)
	      subtree-end)
	     ((org-is-habit-p)
	      subtree-end)
	     (t
	      nil)))))

      (defun bh/skip-non-subprojects ()
	"Skip trees that are not projects"
	(let ((next-headline (save-excursion (outline-next-heading))))
	  (if (bh/is-subproject-p)
	      nil
	    next-headline)))
      ;; ARCHIVING ===========================================================

      (setq org-archive-mark-done nil)
      (setq org-archive-location "%s_archive::* Archived Tasks")

      (defun bh/skip-non-archivable-tasks ()
	"Skip trees that are not available for archiving"
	(save-restriction
	  (widen)
	  ;; Consider only tasks with done todo headings as archivable candidates
	  (let ((next-headline (save-excursion (or (outline-next-heading) (point-max))))
		(subtree-end (save-excursion (org-end-of-subtree t))))
	    (if (member (org-get-todo-state) org-todo-keywords-1)
		(if (member (org-get-todo-state) org-done-keywords)
		    (let* ((daynr (string-to-number (format-time-string "%d" (current-time))))
			   (a-month-ago (* 60 60 24 (+ daynr 1)))
			   (last-month (format-time-string "%Y-%m-" (time-subtract (current-time) (seconds-to-time a-month-ago))))
			   (this-month (format-time-string "%Y-%m-" (current-time)))
			   (subtree-is-current (save-excursion
						 (forward-line 1)
						 (and (< (point) subtree-end)
						      (re-search-forward (concat last-month "\\|" this-month) subtree-end t)))))
		      (if subtree-is-current
			  subtree-end ; Has a date in this month or last month, skip it
			nil))  ; available to archive
		  (or subtree-end (point-max)))
	      next-headline))))

      ;; Appointment Reminders =============================================

      ; Erase all reminders and rebuilt reminders for today from the agenda
      (defun bh/org-agenda-to-appt ()
	(interactive)
	(setq appt-time-msg-list nil)
	(org-agenda-to-appt))

      ; Rebuild the reminders everytime the agenda is displayed
      (add-hook 'org-finalize-agenda-hook 'bh/org-agenda-to-appt 'append)

      ; This is at the end of my .emacs - so appointments are set up when Emacs starts
      (bh/org-agenda-to-appt)

      ; Activate appointments so we get notifications
      (appt-activate t)

      ; If we leave Emacs running overnight - reset the appointments one minute after midnight
      (run-at-time "24:01" nil 'bh/org-agenda-to-appt)

      ;; Narrowing/Widening behavior =============================================
      (global-set-key (kbd "<f5>") 'bh/org-todo)

      (defun bh/org-todo (arg)
	(interactive "p")
	(if (equal arg 4)
	    (save-restriction
	      (bh/narrow-to-org-subtree)
	      (org-show-todo-tree nil))
	  (bh/narrow-to-org-subtree)
	  (org-show-todo-tree nil)))

      (global-set-key (kbd "<S-f5>") 'bh/widen)

      (defun bh/widen ()
	(interactive)
	(if (equal major-mode 'org-agenda-mode)
	    (progn
	      (org-agenda-remove-restriction-lock)
	      (when org-agenda-sticky
		(org-agenda-redo)))
	  (widen)))

      (add-hook 'org-agenda-mode-hook
		'(lambda () (org-defkey org-agenda-mode-map "W" (lambda () (interactive) (setq bh/hide-scheduled-and-waiting-next-tasks t) (bh/widen))))
		'append)

      (defun bh/restrict-to-file-or-follow (arg)
	"Set agenda restriction to 'file or with argument invoke follow mode.
      I don't use follow mode very often but I restrict to file all the time
      so change the default 'F' binding in the agenda to allow both"
	(interactive "p")
	(if (equal arg 4)
	    (org-agenda-follow-mode)
	  (widen)
	  (bh/set-agenda-restriction-lock 4)
	  (org-agenda-redo)
	  (beginning-of-buffer)))

      (add-hook 'org-agenda-mode-hook
		'(lambda () (org-defkey org-agenda-mode-map "F" 'bh/restrict-to-file-or-follow))
		'append)

      (defun bh/narrow-to-org-subtree ()
	(widen)
	(org-narrow-to-subtree)
	(save-restriction
	  (org-agenda-set-restriction-lock)))

      (defun bh/narrow-to-subtree ()
	(interactive)
	(if (equal major-mode 'org-agenda-mode)
	    (progn
	      (org-with-point-at (org-get-at-bol 'org-hd-marker)
		(bh/narrow-to-org-subtree))
	      (when org-agenda-sticky
		(org-agenda-redo)))
	  (bh/narrow-to-org-subtree)))

      (add-hook 'org-agenda-mode-hook
		'(lambda () (org-defkey org-agenda-mode-map "N" 'bh/narrow-to-subtree))
		'append)

      (defun bh/narrow-up-one-org-level ()
	(widen)
	(save-excursion
	  (outline-up-heading 1 'invisible-ok)
	  (bh/narrow-to-org-subtree)))

      (defun bh/get-pom-from-agenda-restriction-or-point ()
	(or (and (marker-position org-agenda-restrict-begin) org-agenda-restrict-begin)
	    (org-get-at-bol 'org-hd-marker)
	    (and (equal major-mode 'org-mode) (point))
	    org-clock-marker))

      (defun bh/narrow-up-one-level ()
	(interactive)
	(if (equal major-mode 'org-agenda-mode)
	    (progn
	      (org-with-point-at (bh/get-pom-from-agenda-restriction-or-point)
		(bh/narrow-up-one-org-level))
	      (org-agenda-redo))
	  (bh/narrow-up-one-org-level)))

      (add-hook 'org-agenda-mode-hook
		'(lambda () (org-defkey org-agenda-mode-map "U" 'bh/narrow-up-one-level))
		'append)

      (defun bh/narrow-to-org-project ()
	(widen)
	(save-excursion
	  (bh/find-project-task)
	  (bh/narrow-to-org-subtree)))

      (defun bh/narrow-to-project ()
	(interactive)
	(if (equal major-mode 'org-agenda-mode)
	    (progn
	      (org-with-point-at (bh/get-pom-from-agenda-restriction-or-point)
		(bh/narrow-to-org-project)
		(save-excursion
		  (bh/find-project-task)
		  (org-agenda-set-restriction-lock)))
	      (org-agenda-redo)
	      (beginning-of-buffer))
	  (bh/narrow-to-org-project)
	  (save-restriction
	    (org-agenda-set-restriction-lock))))

      (add-hook 'org-agenda-mode-hook
		'(lambda () (org-defkey org-agenda-mode-map "P" 'bh/narrow-to-project))
		'append)

      (defvar bh/project-list nil)

      (defun bh/view-next-project ()
	(interactive)
	(let (num-project-left current-project)
	  (unless (marker-position org-agenda-restrict-begin)
	    (goto-char (point-min))
	    ; Clear all of the existing markers on the list
	    (while bh/project-list
	      (set-marker (pop bh/project-list) nil))
	    (re-search-forward "Tasks to Refile")
	    (forward-visible-line 1))

	  ; Build a new project marker list
	  (unless bh/project-list
	    (while (< (point) (point-max))
	      (while (and (< (point) (point-max))
			  (or (not (org-get-at-bol 'org-hd-marker))
			      (org-with-point-at (org-get-at-bol 'org-hd-marker)
				(or (not (bh/is-project-p))
				    (bh/is-project-subtree-p)))))
		(forward-visible-line 1))
	      (when (< (point) (point-max))
		(add-to-list 'bh/project-list (copy-marker (org-get-at-bol 'org-hd-marker)) 'append))
	      (forward-visible-line 1)))

	  ; Pop off the first marker on the list and display
	  (setq current-project (pop bh/project-list))
	  (when current-project
	    (org-with-point-at current-project
	      (setq bh/hide-scheduled-and-waiting-next-tasks nil)
	      (bh/narrow-to-project))
	    ; Remove the marker
	    (setq current-project nil)
	    (org-agenda-redo)
	    (beginning-of-buffer)
	    (setq num-projects-left (length bh/project-list))
	    (if (> num-projects-left 0)
		(message "%s projects left to view" num-projects-left)
	      (beginning-of-buffer)
	      (setq bh/hide-scheduled-and-waiting-next-tasks t)
	      (error "All projects viewed.")))))

      (add-hook 'org-agenda-mode-hook
		'(lambda () (org-defkey org-agenda-mode-map "V" 'bh/view-next-project))
		'append)
      (setq org-show-entry-below (quote ((default))))

      ;; limiting agenda to a subtree:
      (add-hook 'org-agenda-mode-hook
		'(lambda () (org-defkey org-agenda-mode-map "\C-c\C-x<" 'bh/set-agenda-restriction-lock))
		'append)

      (defun bh/set-agenda-restriction-lock (arg)
	"Set restriction lock to current task subtree or file if prefix is specified"
	(interactive "p")
	(let* ((pom (bh/get-pom-from-agenda-restriction-or-point))
	       (tags (org-with-point-at pom (org-get-tags-at))))
	  (let ((restriction-type (if (equal arg 4) 'file 'subtree)))
	    (save-restriction
	      (cond
	       ((and (equal major-mode 'org-agenda-mode) pom)
		(org-with-point-at pom
		  (org-agenda-set-restriction-lock restriction-type))
		(org-agenda-redo))
	       ((and (equal major-mode 'org-mode) (org-before-first-heading-p))
		(org-agenda-set-restriction-lock 'file))
	       (pom
		(org-with-point-at pom
		  (org-agenda-set-restriction-lock restriction-type))))))))

      ;; Always hilight the current agenda line
      (add-hook 'org-agenda-mode-hook
		'(lambda () (hl-line-mode 1))
		'append)
      ;; add calendar to Diary
      (add-hook 'org-agenda-cleanup-fancy-diary-hook
		(lambda ()
		  (goto-char (point-min))
		  (save-excursion
		    (while (re-search-forward "^[a-z]" nil t)
		      (goto-char (match-beginning 0))
		      (insert "0:00-24:00 ")))
		  (while (re-search-forward "^ [a-z]" nil t)
		    (goto-char (match-beginning 0))
		    (save-excursion
		      (re-search-backward "^[0-9]+:[0-9]+-[0-9]+:[0-9]+ " nil t))
		    (insert (match-string 0)))))

      ;; Add Diary info to agenda
      (setq org-agenda-include-diary t)
      (setq org-agenda-diary-file "~/Nextcloud/org/diary.org")
      (setq org-agenda-insert-diary-extract-time t)

      ;; Include agenda archive files when searching for things
      (setq org-agenda-text-search-extra-files (quote (agenda-archives)))

      ;; Show all future entries for repeating tasks
      (setq org-agenda-repeating-timestamp-show-all t)

      ;; Show all agenda dates - even if they are empty
      (setq org-agenda-show-all-dates t)

      ;; Sorting order for tasks on the agenda
      (setq org-agenda-sorting-strategy
	    (quote ((agenda habit-down time-up user-defined-up effort-up category-keep)
		    (todo category-up effort-up)
		    (tags category-up effort-up)
		    (search category-up))))

      ;; Start the weekly agenda on Monday
      (setq org-agenda-start-on-weekday 1)


      ;; Display tags farther right
      (setq org-agenda-tags-column -102)

      ;;
      ;; Agenda sorting functions
      ;;
      (setq org-agenda-cmp-user-defined 'bh/agenda-sort)

      (defun bh/agenda-sort (a b)
	"Sorting strategy for agenda items.
      Late deadlines first, then scheduled, then non-late deadlines"
	(let (result num-a num-b)
	  (cond
	   ; time specific items are already sorted first by org-agenda-sorting-strategy

	   ; non-deadline and non-scheduled items next
	   ((bh/agenda-sort-test 'bh/is-not-scheduled-or-deadline a b))

	   ; deadlines for today next
	   ((bh/agenda-sort-test 'bh/is-due-deadline a b))

	   ; late deadlines next
	   ((bh/agenda-sort-test-num 'bh/is-late-deadline '> a b))

	   ; scheduled items for today next
	   ((bh/agenda-sort-test 'bh/is-scheduled-today a b))

	   ; late scheduled items next
	   ((bh/agenda-sort-test-num 'bh/is-scheduled-late '> a b))

	   ; pending deadlines last
	   ((bh/agenda-sort-test-num 'bh/is-pending-deadline '< a b))

	   ; finally default to unsorted
	   (t (setq result nil)))
	  result))

      (defmacro bh/agenda-sort-test (fn a b)
	"Test for agenda sort"
	`(cond
	  ; if both match leave them unsorted
	  ((and (apply ,fn (list ,a))
		(apply ,fn (list ,b)))
	   (setq result nil))
	  ; if a matches put a first
	  ((apply ,fn (list ,a))
	   (setq result -1))
	  ; otherwise if b matches put b first
	  ((apply ,fn (list ,b))
	   (setq result 1))
	  ; if none match leave them unsorted
	  (t nil)))

      (defmacro bh/agenda-sort-test-num (fn compfn a b)
	`(cond
	  ((apply ,fn (list ,a))
	   (setq num-a (string-to-number (match-string 1 ,a)))
	   (if (apply ,fn (list ,b))
	       (progn
		 (setq num-b (string-to-number (match-string 1 ,b)))
		 (setq result (if (apply ,compfn (list num-a num-b))
				  -1
				1)))
	     (setq result -1)))
	  ((apply ,fn (list ,b))
	   (setq result 1))
	  (t nil)))

      (defun bh/is-not-scheduled-or-deadline (date-str)
	(and (not (bh/is-deadline date-str))
	     (not (bh/is-scheduled date-str))))

      (defun bh/is-due-deadline (date-str)
	(string-match "Deadline:" date-str))

      (defun bh/is-late-deadline (date-str)
	(string-match "\\([0-9]*\\) d\. ago:" date-str))

      (defun bh/is-pending-deadline (date-str)
	(string-match "In \\([^-]*\\)d\.:" date-str))

      (defun bh/is-deadline (date-str)
	(or (bh/is-due-deadline date-str)
	    (bh/is-late-deadline date-str)
	    (bh/is-pending-deadline date-str)))

      (defun bh/is-scheduled (date-str)
	(or (bh/is-scheduled-today date-str)
	    (bh/is-scheduled-late date-str)))

      (defun bh/is-scheduled-today (date-str)
	(string-match "Scheduled:" date-str))

      (defun bh/is-scheduled-late (date-str)
	(string-match "Sched\.\\(.*\\)x:" date-str))

      ;; Use sticky agenda's so they persist
      (setq org-agenda-sticky t)

      ;; Enforce dependency of projects on their sub-tasks
      (setq org-enforce-todo-dependencies t)

      ;; Show leading stars in order to use Org-indent-mode 
      (setq org-hide-leading-stars nil)

      ;;Org-indent-mode
      (setq org-startup-indented t)
;; Org-Mode:1 ends here

;; [[file:~/.emacs.d/settings.org::*Org-Roam][Org-Roam:1]]
(use-package org-roam
      :ensure t
      :hook
      (after-init . org-roam-mode)
      :custom
      (org-roam-directory "~/Nextcloud/org/roam/")
      :bind (:map org-roam-mode-map
              (("C-c n l" . org-roam)
               ("C-c n f" . org-roam-find-file)
               ("C-c n g" . org-roam-graph-show))
              :map org-mode-map
              (("C-c n i" . org-roam-insert))
              (("C-c n I" . org-roam-insert-immediate))))
;; Org-Roam:1 ends here

;; [[file:~/.emacs.d/settings.org::*Emmet Mode][Emmet Mode:1]]
;; emmet mode 
(use-package emmet-mode)
(add-hook 'web-mode-hook  'emmet-mode) 
(add-hook 'web-mode-before-auto-complete-hooks
    '(lambda ()
     (let ((web-mode-cur-language
  	    (web-mode-language-at-pos)))
               (if (string= web-mode-cur-language "php")
    	   (yas-activate-extra-mode 'php-mode)
      	 (yas-deactivate-extra-mode 'php-mode))
               (if (string= web-mode-cur-language "css")
    	   (setq emmet-use-css-transform t)
      	 (setq emmet-use-css-transform nil)))))
;; Emmet Mode:1 ends here

;; [[file:~/.emacs.d/settings.org::*company mode][company mode:1]]
(use-package company)
  (use-package company-tabnine :ensure t)
  (add-hook 'web-mode-hook 'company-mode)
  (add-hook 'cider-mode-hook 'company-mode)
  (add-hook 'js2-mode-hook 'company-mode)
  (add-hook 'clojure-mode-hook 'company-mode)
  (add-hook 'clojure-mode-hook 'paredit-mode)
(setq company-idle-delay 0)
(setq company-minimum-prefix-length 2)
(setq company-selection-wrap-around t)
  (add-to-list 'company-backends #'company-tabnine)
(use-package company-org-roam
    ;;:when (featurep! :completion company)
    :after org-roam
    :config
    (add-to-list 'company-backends '(company-org-roam company-yasnippet company-dabbrev)))
;; company mode:1 ends here

;; [[file:~/.emacs.d/settings.org::*web-mode][web-mode:1]]
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
    (add-to-list 'auto-mode-alist '("\\.css?\\'" . web-mode))
  (use-package rainbow-mode)
    (defun my-web-mode-hook ()
      "Hooks for Web mode."
      (setq web-mode-markup-indent-offset 2)
      (setq web-mode-code-indent-offset 2)
      (setq web-mode-css-indent-offset 2)
    )
    (add-hook 'web-mode-hook  'my-web-mode-hook)  
     (add-hook 'web-mode-hook 'httpd-start )
    (add-hook 'web-mode-hook 'impatient-mode ) 
(add-hook 'web-mode-hook 'rainbow-mode)
    (setq tab-width 2)

    (setq web-mode-enable-current-column-highlight t)
    (setq web-mode-enable-current-element-highlight t)
;; web-mode:1 ends here

;; [[file:~/.emacs.d/settings.org::*javascript modes][javascript modes:1]]
(use-package js2-mode)
  (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
  (add-to-list 'auto-mode-alist '("\\.json$'" . js2-mode))
  ;;(use-package ac-js2)
(use-package rjsx-mode)

  (add-hook 'js-mode-hook 'js2-minor-mode)
(add-hook 'js-mode-hook 'rjsx-minor-mode)
  (add-hook 'js2-mode-hook 'ac-js2-mode)
  (add-hook 'js-mode-hook
            (lambda()
              (flyspell-prog-mode)
              ))

  ;; Better imenu
  (add-hook 'js2-mode-hook #'js2-imenu-extras-mode)

  (use-package js2-refactor)
  (use-package xref-js2
  :requires ag )


  (add-hook 'js2-mode-hook #'js2-refactor-mode)
  (js2r-add-keybindings-with-prefix "C-c C-r")
  (define-key js2-mode-map (kbd "C-k") #'js2r-kill)
  (use-package tern )
  (use-package tern-auto-complete :requires tern)
  (add-hook 'js-mode-hook (lambda () (tern-mode t)))
  (eval-after-load 'tern
     '(progn
        (require 'tern-auto-complete)
        (tern-ac-setup)))
  (defun delete-tern-process ()
    (interactive)
    (delete-process "Tern"))

  ;; js-mode (which js2 is based on) binds "M-." which conflicts with xref, so
  ;; unbind it.

  (define-key js-mode-map (kbd "M-.") nil)

  (add-hook 'js2-mode-hook (lambda ()
    (add-hook 'xref-backend-functions #'xref-js2-xref-backend nil t)))
  (define-key js2-mode-map (kbd "C-k") #'js2r-kill)
;; javascript modes:1 ends here

;; [[file:~/.emacs.d/settings.org::*Typescript mode][Typescript mode:1]]
;; (use-package typescript-mode :ensure t)
(add-to-list 'auto-mode-alist '("\\.ts\\'" . web-mode))
;; Typescript mode:1 ends here

;; [[file:~/.emacs.d/settings.org::*php mode][php mode:1]]
(use-package php-mode :ensure t)
(add-to-list 'auto-mode-alist '("\\.php\\'" . php-mode))
;; php mode:1 ends here

;; [[file:~/.emacs.d/settings.org::*elfeed][elfeed:1]]
(use-package elfeed 
     :ensure t
     :bind (:map elfeed-search-mode-map
                ("A" . elfeed-show-all)
                ("T" . elfeed-show-tech)
                ("N" . elfeed-show-news)
                ("E" . elfeed-show-emacs)
                ("D" . elfeed-show-daily)
                ("q" . elfeed-save-db-and-bury)))

  ;; use an org file to organise feeds
  (use-package elfeed-org
    :ensure t
    :config
    (elfeed-org)
    (setq rmh-elfeed-org-files (list "~/Nextcloud/elfeed.org")))
   
   (add-hook 'elfeed-search-mode-hook 'turn-off-evil-mode)
  (add-hook 'elfeed-show-mode-hook 'turn-off-evil-mode)

  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; elfeed feed reader                                                     ;;
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;;shortcut functions
  (defun elfeed-show-all ()
    (interactive)
    (bookmark-maybe-load-default-file)
    (bookmark-jump "elfeed-all"))
(defun elfeed-show-tech ()
    (interactive)
    (bookmark-maybe-load-default-file)
    (bookmark-jump "elfeed-tech"))
(defun elfeed-show-news ()
    (interactive)
    (bookmark-maybe-load-default-file)
    (bookmark-jump "elfeed-news"))
  (defun elfeed-show-emacs ()
    (interactive)
    (bookmark-maybe-load-default-file)
    (bookmark-jump "elfeed-emacs"))
  (defun elfeed-show-daily ()
    (interactive)
    (bookmark-maybe-load-default-file)
    (bookmark-jump "elfeed-daily"))

  ;;functions to support syncing .elfeed between machines
  ;;makes sure elfeed reads index from disk before launching
  (defun elfeed-load-db-and-open ()
    "Wrapper to load the elfeed db from disk before opening"
    (interactive)
    (elfeed-db-load)
    (elfeed)
    (elfeed-search-update--force))

  ;;write to disk when quiting
  (defun elfeed-save-db-and-bury ()
    "Wrapper to save the elfeed db to disk before burying buffer"
    (interactive)
    (elfeed-db-save)
    (quit-window))

;; set EWW as default browser
 (setq browse-url-browser-function 'eww-browse-url)

;; browse article in gui browser instead of eww
(defun bjm/elfeed-show-visit-gui ()
  "Wrapper for elfeed-show-visit to use gui browser instead of eww"
  (interactive)
  (let ((browse-url-generic-program "/usr/bin/open"))
    (elfeed-show-visit t)))

(define-key elfeed-show-mode-map (kbd "B") 'bjm/elfeed-show-visit-gui)
;; elfeed:1 ends here
