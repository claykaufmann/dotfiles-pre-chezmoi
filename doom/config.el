(setq user-full-name "Clay Kaufmann"
      user-mail-address "claykaufmann@gmail.com")

(setq undo-limit 80000000
      evil-want-fine-undo t
      auto-save-default t)

;; iterate through camelCase words
(global-subword-mode 1)

(add-to-list 'initial-frame-alist '(fullscreen . maximized))

;; swap to new window when splitting normally
(setq evil-vsplit-window-right t
      evil-split-window-below t)

(setq doom-fallback-buffer-name "► Emacs"
      +doom-dashboard-name "► Doom")

(setq frame-title-format
      '(""
        (:eval
         (if (s-contains-p org-roam-directory (or buffer-file-name ""))
             (replace-regexp-in-string
              ".*/[0-9]*-?" "☰ "
              (subst-char-in-string ?_ ?  buffer-file-name))
           "%b"))
        (:eval
         (let ((project-name (projectile-project-name)))
           (unless (string= "-" project-name)
             (format (if (buffer-modified-p)  " ◉ %s" "  ●  %s") project-name))))))

(setq doom-font (font-spec :family "FiraCode Nerd Font Mono" :size 15)) ; slant 'normal prob not needed

;; set relative lines
(setq display-line-numbers-type 'relative)

;; enable icons
(setq doom-modeline-icon (display-graphic-p))
(setq doom-modeline-major-mode-icon t)
(setq doom-modeline-major-mode-color-icon t)
(setq doom-modeline-buffer-state-icon t)

;; increase branch max length
(setq doom-modeline-vcs-max-length 18)

;; make flycheck show more information
(setq doom-modeline-checker-simple-format nil)

;; display indent info
(setq doom-modeline-indent-info t)

;; change edited file color to orange from red
(custom-set-faces!
  '(doom-modeline-buffer-modified :foreground "orange"))

;; enable modeline icons with emacsclient (technically breaks terminal but no issues for me)
(setq doom-modeline-icon t)

(setq doom-theme 'doom-vibrant)

(custom-set-faces!
  '(org-headline-done :foreground "#565761"))

(custom-set-faces!
  '(tree-sitter-hl-face:property :inherit tree-sitter-hl-face:type.super :slant italic)
  '(tree-sitter-hl-face:function.call :inherit (link font-lock-function-name-face) :weight normal :underline nil)
  '(tree-sitter-hl-face:variable.parameter :foreground "#dda0dd"))

(doom-themes-org-config)

(defun doom-dashboard-draw-ascii-emacs-banner-fn ()
  (let* ((banner
          '(",------.,---.---.,------.,------.,------.   "
            "|      ||   |   |       ||       |          "
            "|------'|   |   |,------||       `------.   "
            "|       |   |   ||      ||              | _ "
            "`------''   '   '`------^`------'`------''-'"))
          (longest-line (apply #'max (mapcar #'length banner))))
         (put-text-property
          (point)
          (dolist (line banner (point))
            (insert (+doom-dashboard--center
                     +doom-dashboard--width
                     (concat
                      line (make-string (max 0 (- longest-line (length line)))
                                        32)))
                    "\n"))
          'face 'doom-dashboard-banner)))

(setq +doom-dashboard-ascii-banner-fn #'doom-dashboard-draw-ascii-emacs-banner-fn)

(defvar splash-phrase-source-folder
  (expand-file-name "misc/splash-phrases" doom-private-dir)
  "A folder of text files with a fun phrase on each line.")

(defvar splash-phrase-sources
  (let* ((files (directory-files splash-phrase-source-folder nil "\\.txt\\'"))
         (sets (delete-dups (mapcar
                             (lambda (file)
                               (replace-regexp-in-string "\\(?:-[0-9]+-\\w+\\)?\\.txt" "" file))
                             files))))
    (mapcar (lambda (sset)
              (cons sset
                    (delq nil (mapcar
                               (lambda (file)
                                 (when (string-match-p (regexp-quote sset) file)
                                   file))
                               files))))
            sets))
  "A list of cons giving the phrase set name, and a list of files which contain phrase components.")

(defvar splash-phrase-set
  (nth (random (length splash-phrase-sources)) (mapcar #'car splash-phrase-sources))
  "The default phrase set. See `splash-phrase-sources'.")

(defun splase-phrase-set-random-set ()
  "Set a new random splash phrase set."
  (interactive)
  (setq splash-phrase-set
        (nth (random (1- (length splash-phrase-sources)))
             (cl-set-difference (mapcar #'car splash-phrase-sources) (list splash-phrase-set))))
  (+doom-dashboard-reload t))

(defvar splase-phrase--cache nil)

(defun splash-phrase-get-from-file (file)
  "Fetch a random line from FILE."
  (let ((lines (or (cdr (assoc file splase-phrase--cache))
                   (cdar (push (cons file
                                     (with-temp-buffer
                                       (insert-file-contents (expand-file-name file splash-phrase-source-folder))
                                       (split-string (string-trim (buffer-string)) "\n")))
                               splase-phrase--cache)))))
    (nth (random (length lines)) lines)))

(defun splash-phrase (&optional set)
  "Construct a splash phrase from SET. See `splash-phrase-sources'."
  (mapconcat
   #'splash-phrase-get-from-file
   (cdr (assoc (or set splash-phrase-set) splash-phrase-sources))
   " "))

(defun doom-dashboard-phrase ()
  "Get a splash phrase, flow it over multiple lines as needed, and make fontify it."
  (mapconcat
   (lambda (line)
     (+doom-dashboard--center
      +doom-dashboard--width
      (with-temp-buffer
        (insert-text-button
         line
         'action
         (lambda (_) (+doom-dashboard-reload t))
         'face 'doom-dashboard-menu-title
         'mouse-face 'doom-dashboard-menu-title
         'help-echo "Random phrase"
         'follow-link t)
        (buffer-string))))
   (split-string
    (with-temp-buffer
      (insert (splash-phrase))
      (setq fill-column (min 70 (/ (* 2 (window-width)) 3)))
      (fill-region (point-min) (point-max))
      (buffer-string))
    "\n")
   "\n"))

(defadvice! doom-dashboard-widget-loaded-with-phrase ()
  :override #'doom-dashboard-widget-loaded
  (setq line-spacing 0.2)
  (insert
   "\n\n"
   (propertize
    (+doom-dashboard--center
     +doom-dashboard--width
     (doom-display-benchmark-h 'return))
    'face 'doom-dashboard-loaded)
   "\n"
   (doom-dashboard-phrase)
   "\n"))

(setq-default indent-tabs-mode nil)

(setq-default tab-width 2)

(map! :leader :desc "Dashboard" "D" #'+doom-dashboard/open)

(map! :leader
      (:prefix ("d" . "dired")
       :desc "Dired jump to current" "j" #'dired-jump)
      (:after dired
       (:map dired-mode-map
        :desc "Peep-dired image previews" "d p" #'peep-dired
        :desc "Dired view file" "d v" #'dired-view-file)))

(map! :leader
      (:prefix ("T" . "treemacs")
       :desc "Treemacs edit workspace" "w" #'treemacs-edit-workspaces)
      (:prefix ("T" . "treemacs")
       :desc "Treemacs next workspace" "n" #'treemacs-next-workspace)
      (:prefix ("T" . "treemacs")
       :desc "Treemacs switch workspace" "s" #'treemacs-switch-workspace))

(map! :leader
      (:prefix ("c")
       :desc "Compile with make" "m" #'+make/run))

(setq lsp-eslint-auto-fix-on-save t)

(add-hook 'js2-mode-hook 'prettier-js-mode)
(add-hook 'js-mode-hook 'prettier-js-mode)
(add-hook 'web-mode-hook 'prettier-js-mode)

(setq-hook! 'js2-mode-hook +format-with-lsp nil)
(setq-hook! 'js-mode-hook +format-with-lsp nil)
(setq-hook! 'web-mode-hook +format-with-lsp nil)

(map! :leader
      (:prefix-map ("P" . "python")
       (:prefix ("c" . "conda")
        :desc "conda env activate" "a" #'conda-env-activate
        :desc "conda env deactivate" "d" #'conda-env-deactivate)))

(map! :leader
      (:prefix ("P")
       (:prefix ("v" . "pyenv")
        :desc "set python version" "s" #'pyenv-mode-set
        :desc "unset python version" "u" #'pyenv-mode-unset)))

(map! :leader
      (:prefix ("P")
       (:prefix ("p" . "poetry")
        :desc "poetry menu" "p" #'poetry)))

(case system-type
  ((gnu/linux)
   (setenv "PATH" (concat ":/home/clayk/.poetry/bin" (getenv "PATH")))
   (add-to-list 'exec-path "/home/clayk/.poetry/bin")
   (custom-set-variables
    '(conda-anaconda-home "/opt/homebrew/Caskroom/miniforge/base")))

  ((darwin)
   (setenv "PATH" (concat ":/Users/claykaufmann/.local/bin" (getenv "PATH")))
   (add-to-list 'exec-path "/Users/claykaufmann/.local/bin")))

(poetry-tracking-mode)



;; (conda-env-autoactivate-mode t)
;; ;; if you want to automatically activate a conda environment on the opening of a file:
;; (add-to-hook 'find-file-hook (lambda () (when (bound-and-true-p conda-project-env-path)
;;                                           (conda-env-activate-for-buffer))))

(use-package! lsp-pyright
  :config
  (add-hook 'conda-postactivate-hook (lambda () (lsp-restart-workspace)))
  (add-hook 'conda-postdeactivate-hook (lambda () (lsp-restart-workspace))))

(setq diary-file "~/Dropbox/Org-Utils/diary")

(setq org-directory "~/Dropbox/Terrapin/")
(setq org-roam-directory "~/Dropbox/Terrapin/")

(add-hook 'org-mode-hook (lambda () (electric-indent-mode -1)))

(setq org-element-use-cache nil)

(defun jpk/org-mode-hook ()
  (company-mode -1))
(add-hook 'org-mode-hook 'jpk/org-mode-hook)

(setq org-latex-create-formula-image-program 'imagemagick)

(setenv "PATH" (concat ":/Library/TeX/texbin/" (getenv "PATH")))
(add-to-list 'exec-path "/Library/TeX/texbin/")

(map! :leader
      (:prefix ("n")
       (:desc "render latex" "L" #'org-latex-preview)))

(defvar vulpea-capture-inbox-file
  (format "~/Dropbox/Terrapin/inbox-%s.org" (system-name))
  "The path to the inbox file.

It is relative to `org-directory', unless it is absolute.")

(after! org
  (setq org-todo-keywords
        '((sequence "TODO(t!)" "PROJ(p!)" "ASGN(a!)" "NEXT(n!)" "ACTV(a!)" "WAIT(w!)" "HOLD(h!)" "BLKD(b@/!)" "|" "DONE(d!)" "CANC(c@)"))))

(after! org
  (setq org-todo-keyword-faces
        '(("ACTV" . "green")
          ("NEXT" . "cyan2")
          ("WAIT" . "orange")
          ("HOLD" . "orange")
          ("BLKD" . "red1")
          ("PROJ" . "gray71")
          ("ASGN" . "DeepPink2"))))

(setq org-enforce-todo-dependencies t)

(after! org
  (setq org-log-into-drawer "LOGBOOK"))

;; Resume clocking task when emacs is restarted
(org-clock-persistence-insinuate)

;; Save the running clock and all clock history when exiting Emacs, load it on startup
(setq org-clock-persist t)

;; Resume clocking task on clock-in if the clock is open
(setq org-clock-in-resume t)

;; prompt to resume an active clock
(setq org-clock-persist-query-resume t)

;; change tasks back to NEXT when clocking out, so it is marked in my agenda in its own area
(setq org-clock-out-switch-to-state "NEXT")

;; Save clock data and state changes and notes in the LOGBOOK drawer
(setq org-clock-into-drawer t)

;; Sometimes I change tasks I'm clocking quickly - this removes clocked tasks
;; with 0:00 duration
(setq org-clock-out-remove-zero-time-clocks t)

;; Clock out when moving task to a done state
(setq org-clock-out-when-done t)

;; Enable auto clock resolution for finding open clocks
(setq org-clock-auto-clock-resolution (quote when-no-clock-is-running))

;; Include current clocking task in clock reports
(setq org-clock-report-include-clocking-task t)

;; use pretty things for the clocktable
(setq org-pretty-entities t)

(custom-theme-set-faces
 'user
 `(org-level-8 ((t)))
 `(org-level-7 ((t)))
 `(org-level-6 ((t)))
 `(org-level-5 ((t (:height 1.05 :inherit outline-5))))
 `(org-level-4 ((t (:height 1.05 :inherit outline-4))))
 `(org-level-3 ((t (:height 1.1 :inherit outline-3))))
 `(org-level-2 ((t (:height 1.2 :inherit outline-2))))
 `(org-level-1 ((t (:height 1.4 :inherit outline-1))))
 `(org-document-title ((t (:height 1.0 :underline nil)))))

;; (add-hook! 'org-mode-hook #'doom-disable-line-numbers-h)

;; (custom-theme-set-faces
;;  'user
;;  '(variable-pitch ((t (:family "Source Sans Pro" :height 180 :weight normal))))
;;  '(fixed-pitch ((t ( :family "FiraCode Nerd Font Mono" :height 150)))))

;; (custom-theme-set-faces
;;  'user
;;  '(org-block ((t (:inherit fixed-pitch))))
;;  '(org-code ((t (:inherit (shadow fixed-pitch)))))
;;  '(org-document-info ((t (:foreground "dark orange"))))
;;  '(org-document-info-keyword ((t (:inherit (shadow fixed-pitch)))))
;;  '(org-indent ((t (:inherit (org-hide fixed-pitch)))))
;;  '(org-meta-line ((t (:inherit (font-lock-comment-face fixed-pitch)))))
;;  '(org-property-value ((t (:inherit fixed-pitch))) t)
;;  '(org-special-keyword ((t (:inherit (font-lock-comment-face fixed-pitch)))))
;;  '(org-table ((t (:inherit fixed-pitch :foreground "#83a598"))))
;;  '(org-verbatim ((t (:inherit variable-pitch)))))

;; (add-hook 'org-mode-hook 'visual-line-mode)
;; (add-hook 'org-mode-hook 'variable-pitch-mode)

(setq org-hide-emphasis-markers t)

(defun my/pretty-symbols ()
  (interactive)
  (setq prettify-symbols-alist
        '(("#+begin_src" . ?)
          ("#+BEGIN_SRC" . ?)
          ("#+end_src" . ?)
          ("#+END_SRC" . ?)
          ("#+header" . ?)
          ("#+HEADER" . ?)
          (":PROPERTIES:" . ?)
          (":properties:" . ?)
          (":LOGBOOK:" . ?)
          (":logbook:" . ?)
          ("[ ]" . ?)
          ("[-]" . ?)
          ("[X]" . ?)
          ("#+BEGIN_QUOTE" . ?)
          ("#+begin_quote" . ?)
          ("#+END_QUOTE" . ?)
          ("#+end_quote" . ?)
          ))
  (prettify-symbols-mode 1))
(add-hook 'org-mode-hook 'my/pretty-symbols)

(after! org
  (setq org-ellipsis "  "))

(setq org-cycle-separator-lines -1)

(font-lock-add-keywords 'org-mode
                        '(("^ *\\([-]\\) "
                           (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))
(font-lock-add-keywords 'org-mode
                        '(("^ *\\([+]\\) "
                           (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "◦"))))))

(use-package org-fancy-priorities
  :diminish
  :demand t
  :defines org-fancy-priorities-list
  :hook (org-mode . org-fancy-priorities-mode)
  :config
  (unless (char-displayable-p ?❗)
    (setq org-fancy-priorities-list '("HIGH" "MID" "LOW" "OPTIONAL"))))

(after! org
  (setq org-capture-templates
        ;; basic todo entry
        '(("t" "todo" entry
           (file vulpea-capture-inbox-file)
           "* TODO %?\n%U\n"
           :kill-buffer t)

          ;; basic note entry
          ("n" "note" entry
           (file vulpea-capture-inbox-file)
           "* Note: %? :note:\n%U\n"
           :kill-buffer t)

          ;; basic thought entry
          ("h" "thought" entry
           (file vulpea-capture-inbox-file)
           "* Thought: %? :thought:\n%U\n"
           :kill-buffer t)

          ;; hw assignment entry for quick logging of hw assignments when needed (can always refile later)
          ("a" "assignment" entry
           (file vulpea-capture-inbox-file)
           "* ASGN %?\n%U\n"
           :kill-buffer t)

          ;; basic meeting note entry
          ("m" "meeting note" entry
           (file vulpea-capture-inbox-file)
           "* Meeting: %? :meeting:\n%U\n"
           :kill-buffer t))))

(setq org-roam-capture-templates
      ;; the default template for a note
      '(("d" "default" plain
         "%?"
         :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
         :unnarrowed t)

        ;; the project template, used for projects WITH A DEADLINE
        ("p" "project" plain "* Overview\n\n* Tasks\n** TODO Set project name and deadline\n\n* Ideas\n\n* Notes\n\n* Meetings\n\n* Resources\n\n* PROJ projectname"
         :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+filetags: project")
         :unnarrowed t)

        ;; the metaproject template, used for projects without a deadline
        ("P" "meta project" plain "* Overview\n\n* Tasks\n** TODO Add project name and set a work schedule\n\n* Thoughts\n\n* Notes\n\n* Meetings\n\n* Resources\n\n* PROJ projectname"
         :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+filetags: metaproject")
         :unnarrowed t)

        ;; class template, used as the homepage for a class
        ("C" "class" plain "* Class Overview\n\n\n* Homework\n\n\n* Notes\n\n\n* Ideas\n"
         :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+filetags: class:classname")
         :unnarrowed t)

        ;; class note template, used for a class note for a class
        ("c" "class-note" plain "* Overview\n\n\n* Notes\n\n\n* References"
         :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+filetags: classnote:classname:class")
         :unnarrowed t)

        ;; a default note template
        ("n" "note" plain "* Overview\n\n* References"
         :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+filetags: note")
         :unnarrowed t)

        ;; data structure and algo templates, two things I have been heavily taking notes on lately
        ("d" "data structure" plain "* %?\n\n* References"
         :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+filetags: software:datastructure")
         :unnarrowed t)
        ("A" "algorithm" plain "* %?\n\n* References"
         :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+filetags: software:algorithm")
         :unnarrowed t)

        ;; a meeting note, used for a meeting (also a normal org capture note used when I do not know where this will go)
        ("m" "meeting" plain "* %?\n\n* Context"
         :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+filetags: meeting")
         :unnarrowed t)

        ;; MOC, or Map of Content, used to find smaller subcategories within the MOC
        ("M" "MOC" plain "* %?\n\n"
         :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+filetags: MOC")
         :unnarrowed t)

        ;; a cooking recipe note, used for storing all of my cooking recipes
        ("R" "cooking recipe" plain "* Overview\n\n\n* Ingredients\n\n* Recipe\n\n* Cooking Log\n** Date\n** Time Taken\n** Thoughts\n* Links\n- [[id:b10487ad-2402-418f-85af-3f1513b1b631][Cooking Recipes]] "
         :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+filetags: recipe")
         :unnarrowed t)

        ("r" "resource" plain "* Overview\n\n\n* References\n"
         :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+filetags: resource")
         :unnarrowed t)

        ("w" "weekly goal setting" plain "* Goals\n\n* Action Items\n"
         :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+filetags: weeklygoals")
         :unnarrowed t)

        ;; an assignment note, used for tracking progress on an assignment
        ("a" "assignment" plain "* Overview\n\n* Tasks\n** TODO add assignment name and deadline\n\n* Notes\n\n* Ideas\n\n* Resources\n\n* ASGN assignmentname"
         :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+filetags: assignment:class")
         :unnarrowed t)))

(setq org-roam-dailies-capture-templates
      '(("d" "default" entry
         "* Tasks\n\n\n* Ideas\n\n\n* Thoughts\n\n\n* Daily Journal\n* [[id:84572ce2-320f-439a-badf-ad24577b493e][Daily Note]] for %<%Y-%m-%d>"
         :target (file+head "%<%Y-%m-%d>.org"
                            "#+title: %<%Y-%m-%d>\n"))))

(setq org-agenda-files (list "~/Dropbox/Terrapin/daily/"
                             "~/Dropbox/Terrapin/"
                             "~/.doom.d/config.org"))

(setq org-agenda-include-diary t)

(setq org-agenda-start-with-log-mode t)
(setq org-agenda-include-deadlines t)
(setq org-deadline-warning-days 7)

;;(setq org-agenda-skip-scheduled-if-deadline-is-shown t)

(setq org-agenda-skip-scheduled-if-done t)
(setq org-agenda-skip-deadline-if-done t)

(setq org-agenda-prefix-format
      '((agenda . " %i %(vulpea-agenda-category 18)%?-14t% s")
        (todo . " %i %(vulpea-agenda-category 18) %-11(let ((deadline (org-get-deadline-time (point)))) (if deadline (format-time-string \"%Y-%m-%d\" deadline) \"\")) ")
        (tags . " %i %(vulpea-agenda-category 18) %t ")
        (search . " %i %(vaulpea-agenda-category 18) %t ")))

(setq org-agenda-format-date
          (lambda (date)
            (concat "\n" (org-agenda-format-date-aligned date))))

(custom-set-faces!
  ;; set the agenda structure font (heading) mainly used to change the color of super agenda group names
  '(org-agenda-structure :slant italic :foreground "green3" :width semi-expanded )

  ;; set the shceduled today font (for some reason it defaults to being dimmed, which was not nice)
  '(org-scheduled-today :foreground "MediumPurple1")

  ;; by default this is white, add some color to make it pop on the time grid
  '(org-agenda-diary :foreground "goldenrod1"))

(org-super-agenda-mode)

(use-package! org-super-agenda
    :config
    (setq org-agenda-start-day nil  ; today
    ))

(setq org-agenda-use-time-grid t)

;; set the span of the default agenda to be a week
(setq org-agenda-span 10)

;; show deadlines

(setq org-agenda-custom-commands

      ;; a refiling view
      '(("r" "Things to refile"
         ((tags
           "REFILE"
           ((org-agenda-overriding-header "To refile:")
            (org-tags-match-list-sublevels nil)))))

        ;; the day view (used most often)
        ("d" "Day View"

         ;; show the base agenda
         ((agenda "" ((org-agenda-span 'day)
                      ;; enable the diary in the daily view so I can see how classes fit into the day
                      (org-agenda-include-diary t)

                      ;; add a hook to call org mac iCal
                      (org-agenda-mode-hook (lambda () (org-mac-iCal)))

                      ;; add 7 days of warning to get things due this week
                      (org-deadline-warning-days 7)
                      ;; set super agenda groups
                      (org-super-agenda-groups
                        ;; main group of today to show the time grid
                       '((:name "Today"
                          :time-grid t
                          :date today
                          :order 1
                          )

                         ;; second group to show all tasks due this week (using deadline-warning-days)
                         (:name "Due this week"
                          :todo t
                          :order 4)))))

          ;; show a bunch of different todo groups
          (alltodo "" ((org-agenda-overriding-header "")
                       (org-super-agenda-groups
                        ;; next up are all todos marked NEXT
                        '((:name "Next up"
                           :todo "NEXT"
                           :discard (:todo "PROJ")
                           :discard (:tag "REFILE")
                           :order 1)

                          ;; all taks with a priority of A
                          (:name "Important"
                           :priority "A"
                           :order 3)

                          ;; tasks that are estimated to be less than 30 minutes
                          (:name "Quick Picks"
                           :effort< "0:30"
                           :order 5)

                          ;; overdue tasks
                          (:name "Overdue"
                           :deadline past
                           :order 4)

                          ;; assignments for school
                          (:name "Assignments"
                           :tag "assignment"
                           :todo "ASGN"
                           :order 6)

                          ;; general UVM tasks
                          (:name "UVM"
                           :tag "class"
                           :discard (:todo "PROJ")
                           :order 6)

                          ;; tasks with no due date
                          (:name "No due date"
                           :deadline nil
                           :order 70
                           )

                          ;; emacs related tasks (before projects to separate them)
                          (:name "Emacs"
                           :tag "emacs"
                           :order 9)

                          ;; all projects, hide the PROJ tag to avoid duplication (the tag will appear if the due date is coming up in the top week section)
                          (:name "Projects"
                           :discard (:todo "PROJ")
                           :tag ("project" "metaproject")
                           :order 7)

                          (:name "Others"
                           :deadline t
                           :order 10)

                          ;; discard all things with the REFILE tag, as they will appear in the next group
                          (:discard (:tag "REFILE")
                           :order 80)
                          ))))

          ;; refile section, to show anything that should be refiled
          (tags "REFILE" ((org-agenda-overriding-header "To Refile:")))))))

(defun vulpea-buffer-prop-get (name)
  "Get a buffer property called NAME as a string."
  (org-with-point-at 1
    (when (re-search-forward (concat "^#\\+" name ": \\(.*\\)")
                             (point-max) t)
      (buffer-substring-no-properties
       (match-beginning 1)
       (match-end 1)))))

(defun vulpea-agenda-category (&optional len)
  "Get category of item at point for agenda.

Category is defined by one of the following items:

- CATEGORY property
- TITLE keyword
- TITLE property
- filename without directory and extension

When LEN is a number, resulting string is padded right with
spaces and then truncated with ... on the right if result is
longer than LEN.

Usage example:

  (setq org-agenda-prefix-format
        '((agenda . \" %(vulpea-agenda-category) %?-12t %12s\")))

Refer to `org-agenda-prefix-format' for more information."
  (let* ((file-name (when buffer-file-name
                      (file-name-sans-extension
                       (file-name-nondirectory buffer-file-name))))
         (title (vulpea-buffer-prop-get "title"))
         (category (org-get-category))
         (result
          (or (if (and
                   title
                   (string-equal category file-name))
                  title
                category)
              "")))
    (if (numberp len)
        (s-truncate len (s-pad-right len " " result))
      result)))

(map! :leader
      (:prefix ("n")
       (:prefix ("r")
        :desc "open org roam ui" "o" #'org-roam-ui-open
        :desc "toggle org roam ui" "u" #'org-roam-ui-mode)))

(setq projectile-project-search-path '("~/Projects/"))
(setq projectile-auto-discover t)

(setq magit-todos-mode t)

(add-hook 'magit-mode-hook (lambda () (magit-delta-mode +1)))

(with-eval-after-load 'magit-delta
    (set-face-attribute 'magit-diff-added-highlight nil
              :background "#003800")
    (set-face-attribute 'magit-diff-added nil
              :background "#003800")
    (set-face-attribute 'magit-diff-removed-highlight nil
              :background "#3f0001")
    (set-face-attribute 'magit-diff-removed nil
              :background "#3f0001"))

(add-hook 'magit-delta-mode-hook
            (lambda ()
              (setq face-remapping-alist
                    (seq-difference face-remapping-alist
                                    '((magit-diff-removed . default)
                                      (magit-diff-removed-highlight . default)
                                      (magit-diff-added . default)
                                      (magit-diff-added-highlight . default))))))

(use-package! websocket
  :after org-roam)

(use-package! org-roam-ui
  :after org-roam ;; or :after org
  ;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
  ;;         a hookable mode anymore, you're advised to pick something yourself
  ;;         if you don't care about startup time, use
  ;;  :hook (after-init . org-roam-ui-mode)
  :config
  (setq org-roam-ui-sync-theme t
        org-roam-ui-follow t
        org-roam-ui-update-on-save t
        org-roam-ui-open-on-start t))

(with-eval-after-load 'doom-themes
  (doom-themes-treemacs-config))
(setq doom-themes-treemacs-theme "doom-colors")

(setq treemacs-width 30)

(setq treemacs-position 'left)

(setq vterm-timer-delay 0.0001)

(require 'tree-sitter)

;; config snagged from hlissners private doom cfg
(use-package! tree-sitter
  :when (bound-and-true-p module-file-suffix)
  :hook (prog-mode . tree-sitter-mode)
  :hook (tree-sitter-after-on . tree-sitter-hl-mode)
  :config
  (require 'tree-sitter-langs)
  (defadvice! doom-tree-sitter-fail-gracefully-a (orig-fn &rest args)
    "Don't break with errors when current major mode lacks tree-sitter support."
    :around #'tree-sitter-mode
    (condition-case e
        (apply orig-fn args)
      (error
       (unless (string-match-p (concat "^Cannot find shared library\\|"
                                       "^No language registered\\|"
                                       "cannot open shared object file")
                            (error-message-string e))
            (signal (car e) (cadr e)))))))

;; add a keybinding to toggle highlight mode

(custom-set-faces!
  '(tree-sitter-hl-face:property :inherit tree-sitter-hl-face:type.super :slant italic)
  '(tree-sitter-hl-face:function.call :inherit (link font-lock-function-name-face) :weight normal :underline nil))
