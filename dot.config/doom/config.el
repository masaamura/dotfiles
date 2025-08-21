;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
(setq doom-font (font-spec :family "HackGen Console NF" :size 18 :weight 'semi-light)
      doom-variable-pitch-font (font-spec :family "HackGen Console NF" :size 19))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;;(setq doom-theme 'doom-one)
(setq doom-theme 'doom-dracula)
(setq doom-dracula-brighter-comments t)
;; don't lighten the background of the comment
(setq doom-dracula-comment-bg nil)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Dropbox/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; Set default window size to maximize
;;(add-to-list 'default-frame-alist '(fullscreen . maximized))
;;(add-hook 'window-setup-hook #'toggle-frame-maximized)

(defun my-weebery-is-always-greater ()
  (let* (
         ;;(banner '("⢸⣿⣿⣿⣿⠃⠄⢀⣴⡾⠃⠄⠄⠄⠄⠄⠈⠺⠟⠛⠛⠛⠛⠻⢿⣿⣿⣿⣿⣶⣤⡀⠄"
         ;;          "⢸⣿⣿⣿⡟⢀⣴⣿⡿⠁⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⣸⣿⣿⣿⣿⣿⣿⣿⣷"
         ;;          "⢸⣿⣿⠟⣴⣿⡿⡟⡼⢹⣷⢲⡶⣖⣾⣶⢄⠄⠄⠄⠄⠄⢀⣼⣿⢿⣿⣿⣿⣿⣿⣿⣿"
         ;;          "⢸⣿⢫⣾⣿⡟⣾⡸⢠⡿⢳⡿⠍⣼⣿⢏⣿⣷⢄⡀⠄⢠⣾⢻⣿⣸⣿⣿⣿⣿⣿⣿⣿"
         ;;          "⡿⣡⣿⣿⡟⡼⡁⠁⣰⠂⡾⠉⢨⣿⠃⣿⡿⠍⣾⣟⢤⣿⢇⣿⢇⣿⣿⢿⣿⣿⣿⣿⣿"
         ;;          "⣱⣿⣿⡟⡐⣰⣧⡷⣿⣴⣧⣤⣼⣯⢸⡿⠁⣰⠟⢀⣼⠏⣲⠏⢸⣿⡟⣿⣿⣿⣿⣿⣿"
         ;;          "⣿⣿⡟⠁⠄⠟⣁⠄⢡⣿⣿⣿⣿⣿⣿⣦⣼⢟⢀⡼⠃⡹⠃⡀⢸⡿⢸⣿⣿⣿⣿⣿⡟"
         ;;          "⣿⣿⠃⠄⢀⣾⠋⠓⢰⣿⣿⣿⣿⣿⣿⠿⣿⣿⣾⣅⢔⣕⡇⡇⡼⢁⣿⣿⣿⣿⣿⣿⢣"
         ;;          "⣿⡟⠄⠄⣾⣇⠷⣢⣿⣿⣿⣿⣿⣿⣿⣭⣀⡈⠙⢿⣿⣿⡇⡧⢁⣾⣿⣿⣿⣿⣿⢏⣾"
         ;;          "⣿⡇⠄⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⢻⠇⠄⠄⢿⣿⡇⢡⣾⣿⣿⣿⣿⣿⣏⣼⣿"
         ;;          "⣿⣷⢰⣿⣿⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⢰⣧⣀⡄⢀⠘⡿⣰⣿⣿⣿⣿⣿⣿⠟⣼⣿⣿"
         ;;          "⢹⣿⢸⣿⣿⠟⠻⢿⣿⣿⣿⣿⣿⣿⣿⣶⣭⣉⣤⣿⢈⣼⣿⣿⣿⣿⣿⣿⠏⣾⣹⣿⣿"
         ;;          "⢸⠇⡜⣿⡟⠄⠄⠄⠈⠙⣿⣿⣿⣿⣿⣿⣿⣿⠟⣱⣻⣿⣿⣿⣿⣿⠟⠁⢳⠃⣿⣿⣿"
         ;;          "⠄⣰⡗⠹⣿⣄⠄⠄⠄⢀⣿⣿⣿⣿⣿⣿⠟⣅⣥⣿⣿⣿⣿⠿⠋⠄⠄⣾⡌⢠⣿⡿⠃"
         ;;          "⠜⠋⢠⣷⢻⣿⣿⣶⣾⣿⣿⣿⣿⠿⣛⣥⣾⣿⠿⠟⠛⠉⠄⠄          "))
         (banner '("D O O M"))
         (longest-line (apply #'max (mapcar #'length banner))))
    (put-text-property
     (point)
     (dolist (line banner (point))
       (insert (+doom-dashboard--center
                +doom-dashboard--width
                (concat line
                        (make-string (max 0 (- longest-line (length line))) 32)))
               "\n"))
     'face 'doom-dashboard-banner)))

;;(setq +doom-dashboard-ascii-banner-fn #'my-weebery-is-always-greater)
;;(setq +doom-dashboard-ascii-banner-fn nil)

(add-hook 'prog-mode-hook
          (lambda ()
            ;; (message "prog-mode-hook reverting `%s'..." (buffer-name))
            ))

;; display-fill-column-indicator
(add-hook 'prog-mode-hook
          (lambda ()
            ;; 79文字制限の表示
            (setq-default display-fill-column-indicator-column 79)
            (setq-default display-fill-column-indicator-character ?\N{U+007C})
            (setq display-fill-column-indicator t)
            ))

;; highlight-indent-guides
(after! highlight-indent-guides
  (setq highlight-indent-guides-method 'character)
  (setq highlight-indent-guides-auto-enabled nil)
  ;;(set-face-background 'highlight-indent-guides-odd-face "#8080c0")
  ;;(set-face-background 'highlight-indent-guides-even-face "#8080c0")
  ;;(set-face-foreground 'highlight-indent-guides-character-face "#202080")
  (set-face-background 'highlight-indent-guides-odd-face "darkgray")
  (set-face-background 'highlight-indent-guides-even-face "dimgray")
  (set-face-foreground 'highlight-indent-guides-character-face "dimgray")
  )
(add-hook 'prog-mode-hook
          (lambda ()
            (highlight-indent-guides-mode)
            ))

;; Highlight trailing whitespace
(setq-default show-trailing-whitespace t)

;; Disable trailing whitespace highlighting when in some modes
;; https://qiita.com/tadsan/items/df73c711f921708facdc
(defun my/disable-trailing-mode-hook ()
  "Disable show tail whitespace."
  (setq show-trailing-whitespace nil))

(defvar my/disable-trailing-modes
  '(comint-mode
    eshell-mode
    eww-mode
    term-mode
    twittering-mode
    mu4e-main-mode))

(mapc
 (lambda (mode)
   (add-hook (intern (concat (symbol-name mode) "-hook"))
             'my/disable-trailing-mode-hook))
 my/disable-trailing-modes)

;; highlight tab, hard space, and full-width space
(require 'whitespace)
(setq whitespace-style '(
                         face
                         tabs
                         spaces
                         space-mark
                         tab-mark
                         ))
(setq whitespace-display-mappings
      '(
        (space-mark ?\u3000 [?␣])       ; full-width space AMBIGUOUS WIDTH!
        (space-mark ?\u00A0 [?\uFF65])  ; hard space
        (tab-mark   ?\t     [?» ?\t])   ; tab
        ))
(setq whitespace-space-regexp "\\([\u3000]+\\)") ; highlight only full-width space
(global-whitespace-mode t)

;;turn off auto-fill
(add-hook 'markdown-mode-hook (lambda () (auto-fill-mode -1)))

;;soft wrapping
(global-visual-line-mode t)

;;resize window quickly
;;http://d.hatena.ne.jp/khiker/20100119/window_resize
(defun my-window-resizer ()
  "Control window size and position."
  (interactive)
  (let ((window-obj (selected-window))
        (current-width (window-width))
        (current-height (window-height))
        (dx (if (= (nth 0 (window-edges)) 0) 1
              -1))
        (dy (if (= (nth 1 (window-edges)) 0) 1
              -1))
        action c)
    (catch 'end-flag
      (while t
        (setq action
              (read-key-sequence-vector (format "size[%dx%d]"
                                                (window-width)
                                                (window-height))))
        (setq c (aref action 0))
        (cond ((= c ?l)
               (enlarge-window-horizontally (* dx 5)))
              ((= c ?L)
               (enlarge-window-horizontally dx))
              ((= c ?h)
               (shrink-window-horizontally (* dx 5)))
              ((= c ?H)
               (shrink-window-horizontally dx))
              ((= c ?j)
               (enlarge-window (* dy 2)))
              ((= c ?J)
               (enlarge-window dy))
              ((= c ?k)
               (shrink-window (* dy 2)))
              ((= c ?K)
               (shrink-window dy))
              ;; otherwise
              (t
               (let ((last-command-char (aref action 0))
                     (command (key-binding action)))
                 (when command
                   (call-interactively command)))
               (message "Quit")
               (throw 'end-flag t)))))))

(map! :map evil-window-map
      "SPC" #'my-window-resizer) ; CTRL-w SPC or SPC w SPC

;; which-key で C-h を使う
(setq which-key-use-C-h-commands t)
;; でも SPC w C-h が使われているので、関連キーバインドを削除
;; (この削除された機能は上の my-window-resizer を使う)
(map! :map evil-window-map
      "C-h" nil
      "C-j" nil
      "C-k" nil
      "C-l" nil)

;; sly
(setq sly-command-switch-to-existing-lisp "sbcl")

;; frame size
;;(if (boundp 'window-system)
;;    (setq default-frame-alist
;;          (append (list
;;                   '(width  . 90)
;;                   '(height .  40)
;;                   )
;;                  default-frame-alist)))
;;                                        ;(setq initial-frame-alist default-frame-alist)

;;(add-hook 'evil-mode-hook
;;          (lambda ()
;;            (when (member major-mode '(mew-summary-mode another-mode))
;;              (setq evil-mode nil))))

;;(add-hook 'mew-summary-mode-hook
;;          (lambda ()
;;            (evil-emacs-state)))

(map! :leader
      :desc "evil emacs state" "\\" #'evil-emacs-state)

;;(require 'doom-modeline)
;;(doom-modeline-mode 1)

;; skk
(setq default-input-method "japanese-skk")

;; ddskkの辞書ファイルの設定 (お使いの環境に合わせてパスを調整してください)
(setq skk-jisyo-file "~/.skk-jisyo") ; 個人辞書
(setq skk-large-jisyo "/usr/share/skk/SKK-JISYO.L") ; 大規模辞書
;; 必要であれば、追加の辞書
;; (setq skk-jisyo-codes '("utf-8" "euc-jp" "sjis")) ; 辞書ファイルのエンコーディング

;; C-j で SKK mode のオン/オフを切り替える (お好みで)
;; (global-set-key "\C-j" 'toggle-input-method)

;; その他のddskkの設定例 (必要に応じて追加)
;; かな入力モードのデフォルトをひらがなにする
;; (setq skk-kana-default-p t)

;; ローマ字テーブルの変更 (お好みで)
;; (setq skk-rom-kana-rule-list skk-rom-kana-rule-list-hepburn)

;; SKKサーバーを利用する場合 (fcitx5-skkとの連携は通常不要ですが、Emacs内でSKKサーバを立てる場合など)
;; (setq skk-server-port 1178)
;; (setq skk-server-host "localhost")
;; (skk-start-server)

;; パスの設定を読み込む
(exec-path-from-shell-initialize)

;; mu4e
;; tell mu4e
(add-to-list 'load-path "/usr/share/emacs/site-lisp/elpa-src/mu4e-1.12.6")

;; メールのファイルを最近使ったファイルから除外する
(eval-after-load 'recentf
  '(add-to-list 'recentf-exclude (expand-file-name "~/Maildir/")))
;;(with-eval-after-load 'recentf
;;  (add-to-list 'recentf-exclude (expand-file-name "~/Maildir/")))

;; use mu4e for e-mail in emacs
(setq mail-user-agent 'mu4e-user-agent)

(after! mu4e
  ;; send mail
  (setq sendmail-program (executable-find "msmtp")
        send-mail-function #'smtpmail-send-it
        message-sendmail-f-is-evil t
        message-sendmail-extra-arguments '("--read-envelope-from")
        message-send-mail-function #'message-send-mail-with-sendmail)

  ;; setup accounts
  (setopt mu4e-contexts
          (list
           (make-mu4e-context
            :name "m masaamura"
            :enter-func(lambda () (mu4e-message "Switch to the masaamura context"))
            :leave-func (lambda () (mu4e-message "Leaving the masaamura context"))
            :match-func (lambda (msg)
                          (when msg
                            (string-prefix-p "/Gmail/masaamura" (mu4e-message-field msg :maildir))))
            :vars `((user-mail-address . "masaamura@gmail.com")
                    (user-full-name     . "MURAKAMI Masami")
                    (mu4e-sent-folder   . "/Gmail/masaamura/[Gmail]/Sent Mail")
                    (mu4e-trash-folder  . "/Gmail/masaamura/[Gmail]/Trash")
                    (mu4e-drafts-folder . "/Gmail/masaamura/[Gmail]/Drafts")
                    (mu4e-compose-signature . (concat "-----\n" "MURAKAMI Masami"))
                    (mu4e-maildir-shortcuts . (("/Gmail/masaamura/INBOX" . ?i)
                                               ("/Gmail/masaamura/[Gmail]/Sent Mail" . ?s)
                                               ("/Gmail/masaamura/[Gmail]/Drafts" . ?d)
                                               ("/Gmail/masaamura/[Gmail]/Trash" . ?t)))))
           (make-mu4e-context
            :name "h chradis"
            :enter-func(lambda () (mu4e-message "Switch to the chradis context"))
            :leave-func (lambda () (mu4e-message "Leaving the chradis context"))
            :match-func (lambda (msg)
                          (when msg
                            (string-prefix-p "/Gmail/chradis" (mu4e-message-field msg :maildir))))
            :vars `((user-mail-address . "chradis@gmail.com")
                    (user-full-name     . "MURAKAMI Masami")
                    (mu4e-sent-folder   . "/Gmail/chradis/[Gmail]/Sent Mail")
                    (mu4e-trash-folder  . "/Gmail/chradis/[Gmail]/Trash")
                    (mu4e-drafts-folder . "/Gmail/chradis/[Gmail]/Drafts")
                    (mu4e-compose-signature . (concat "-----\n" "MURAKAMI Masami"))
                    (mu4e-maildir-shortcuts . (("/Gmail/chradis/INBOX" . ?i)
                                               ("/Gmail/chradis/[Gmail]/Sent Mail" . ?s)
                                               ("/Gmail/chradis/[Gmail]/Drafts" . ?d)
                                               ("/Gmail/chradis/[Gmail]/Trash" . ?t)))))
           (make-mu4e-context
            :name "p capastic"
            :enter-func(lambda () (mu4e-message "Switch to the capastic context"))
            :leave-func (lambda () (mu4e-message "Leaving the capastic context"))
            :match-func (lambda (msg)
                          (when msg
                            (string-prefix-p "/Gmail/capastic" (mu4e-message-field msg :maildir))))
            :vars `((user-mail-address . "capastic@gmail.com")
                    (user-full-name     . "MURAKAMI Masami")
                    (mu4e-sent-folder   . "/Gmail/capastic/[Gmail]/Sent Mail")
                    (mu4e-trash-folder  . "/Gmail/capastic/[Gmail]/Trash")
                    (mu4e-drafts-folder . "/Gmail/capastic/[Gmail]/Drafts")
                    (mu4e-compose-signature . (concat "-----\n" "MURAKAMI Masami"))
                    (mu4e-maildir-shortcuts . (("/Gmail/capastic/INBOX" . ?i)
                                               ("/Gmail/capastic/[Gmail]/Sent Mail" . ?s)
                                               ("/Gmail/capastic/[Gmail]/Drafts" . ?d)
                                               ("/Gmail/capastic/[Gmail]/Trash" . ?t)))))
           ;;(make-mu4e-context
           ;; :name "main"
           ;; :enter-func(lambda () (mu4e-message "Switch to the Main context"))
           ;; :leave-func (lambda () (mu4e-message "Leaving the Main context"))
           ;; :match-func (lambda (msg)
           ;;               (when msg
           ;;                 (string-prefix-p "/main" (mu4e-message-field msg :maildir))))
           ;; :vars `((user-mail-address . ,(offlineimap-get-username "offlineimap-main"))
           ;;         (user-full-name . ,(plist-get (nth 0 (auth-source-search :host "offlineimap-main")) :fullname))
           ;;         (mu4e-sent-folder . "/main/[Gmail].送信済みメール")
           ;;         (mu4e-drafts-folder . "/main/[Gmail].下書き")
           ;;         (mu4e-trash-folder . "/main/[Gmail].ゴミ箱")
           ;;         (mu4e-refile-folder . "/main/[Gmail].すべてのメール")
           ;;         (mu4e-compose-signature . ,(concat (plist-get (nth 0 (auth-source-search :host "offlineimap-main")) :fullname) "\n"))
           ;;         (mu4e-maildir-shortcuts . ((:maildir "/main/INBOX"                  :key ?i :name "INBOX")
           ;;                                    (:maildir "/main/[Gmail].送信済みメール" :key ?s :name "送信済み")
           ;;                                    (:maildir "/main/[Gmail].すべてのメール" :key ?a :name "すべてのメール")
           ;;                                    (:maildir "/main/[Gmail].下書き"         :key ?d :name "下書き")
           ;;                                    (:maildir "/main/[Gmail].ゴミ箱"         :key ?t :name "ゴミ箱")                  (mu4e-maildir-shortcuts . (("/main/INBOX" . ?i)
           ))

  ;; old style
  ;;(set-email-account!
  ;; "masaamura"
  ;; '((mu4e-sent-folder   . "/Gmail/masaamura/[Gmail]/Sent Mail")
  ;;   (mu4e-trash-folder  . "/Gmail/masaamura/[Gmail]/Trash")
  ;;   (mu4e-drafts-folder . "/Gmail/masaamura/[Gmail]/Drafts")
  ;;   (smtpmail-smtp-user . "masaamura@gmail.com")
  ;;   (user-full-name     . "MURAKAMI Masami")
  ;;   (user-mail-address  . "masaamura@gmail.com"))
  ;; t)

  (setq mu4e-attachment-dir "~/Downloads")

  (setq
   ;; more sensible date format
                                        ;mu4e-headers-date-format "%d.%m.%y"
   mu4e-headers-time-format "%T" ;; format for today
   mu4e-headers-date-format "%D %T" ;; format for older
   mu4e-headers-fields
   '((:human-date . 20) (:flags . 6) (:mailing-list . 6) (:from . 22) (:subject)))

  (setq
   ;; get mail command 'mbsync'
   mu4e-get-mail-command (concat (expand-file-name "~/bin/isync/bin/mbsync") " -a")
   ;; get emails and index every 5 minutes
   mu4e-update-interval (* 60 5)
   ;; don't do a full cleanup check
   mu4e-index-cleanup nil
   ;; don't consider up-to-date dirs
   mu4e-index-lazy-check t)

  (setq
   ;; send emails with format=flowed
   mu4e-compose-format-flowed t
   ;; don't save messages to Sent Messages, Gmail/IMAP takes care of this
   mu4e-sent-messages-behavior 'delete)

  ;; for html mail in dark theme
  (setq shr-color-visible-luminance-min 80)
  )

;;(require 'server)
;;(unless (server-running-p)
;;  (server-start))

(defun my/set-transparent-background ()
  "Set background transparency."
  (set-frame-parameter (selected-frame) 'alpha-background 90) ; 0〜100の範囲。小さいほど透明
  (add-to-list 'default-frame-alist '(alpha-background . 90)))

(add-hook 'after-init-hook #'my/set-transparent-background)
