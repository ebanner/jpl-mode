; "{≢ ⍺ ↑ {:⍤1 ⍋⍨ (≢,⊃) ⌸⍨ ⍵}"
;
; {{ # x{. {: "1 \:~ (#,{.) /.~ y }}

(require 'quail)

(setq pairs
      '(("⍵" . " y ")
        ("⍨" . "~")
        ("˜" . "~")
        ("⌸" . "/.")
        ("≢" . "#")
        ("⍒" . "\\\\:")
        ("⍋" . "/:")
        ("⍤" . "\"")
        ("↑" . "{.")
        ;; ("{:" . "*tail*")
        ;; ("}:" . "*curtail*")
        ("{" . "{{")
        ("}" . "}}")
        ("⍺" . "x")
        ("⊃" . "{.")
        ("∨" . "+.")
        ("×" . "*")
        ("⍳" . " i.")
        ("⌷" . "{")
        ("~" . "-.")
        ("∪" . "~.")
        ("↕" . "<\\\\")
        ("←" . "=:")
        ("¨" . "&>")
        ("∘" . "@")
        ("∧" . "*.")
        ("∨" . "+.")
        ("´" . "/")
        ("↓" . "}.")
        ("≠" . "~:")
        ("¯" . "_")
        ("⍸" . "I.")
        ("⊢" . "]")
        ("⍣" . "^:")
        ("≤" . "<:")
        ("∞" . "_")
        ("≥" . ">:")
        ("⍴" . "$")
        ("÷" . "%")
        ("⍬" . "a:")
        ("⊏" . "{")
        ("†" . "}:")
        ("⌈" . ">.")
        ("⌊" . "<.")
        ("⌺" . ";.")
        ("⊸" . "&")
        ("⟜" . "&")
        ("⍎" . "\".")
        ("⎕C" . "tolower")
        ("⊐" . "{:")
        ("⊥" . "#.")
        ("⊤" . "#:")
        ("*" . "^")
        ))

(setq pairs2
      '(("*tail*" . "{:")
        ("*curtail*" . "}:")
        ))

(defun apl->j (apl-str)

  (setq apl-str
        (let ((regexp (regexp-opt (mapcar #'car pairs))))
          (replace-regexp-in-string
           regexp
           (lambda (match)
             (pcase (assoc match pairs)
               (`(,_ . ,new) new)))
           apl-str)))

  (let ((regexp (regexp-opt (mapcar #'car pairs2))))
    (replace-regexp-in-string
     regexp
     (lambda (match)
       (pcase (assoc match pairs2)
         (`(,_ . ,new) new)))
     apl-str)))

(defun my-send-line-to-j ()
  (interactive)

  (let* ((text (string-trim
                (if (use-region-p)
                    (buffer-substring (region-beginning) (region-end))
                  (thing-at-point 'line t))))
         (apl-text (apl->j text))
         (win (get-buffer-window "*J*")))

    (message "%s" apl-text)

    (with-current-buffer (get-buffer "*J*")
      (goto-char (point-max))
      (insert apl-text)
      (comint-send-input))

    (when win
      (set-window-point win (with-current-buffer "*J*" (point-max))))))

(global-set-key (kbd "TAB") #'my-send-line-to-j)

(quail-define-package "apl-dot" "UTF-8" "•" t
                      "APL dot+letter replacement"
                      '(("\t" . quail-completion))
                      t                 ; forget-last-selection
                      nil               ; deterministic
                      nil               ; kbd-translate
                      t                 ; show-layout
                      nil               ; create-decode-map
                      nil               ; maximum-shortest
                      nil               ; overlay-plist
                      nil               ; update-translation-function
                      nil               ; conversion-keys
                      t                 ; simple
                      )

(defvar apl-dot--transcription-alist
  '(;; Top row
    ("``" . "⋄")    ; diamond
    ("\\diamond" . "⋄")    ; diamond
    ("`1" . "¨")    ; diaeresis
    ("\\each" . "¨")    ; diaeresis
    ("`!" . "⌶")    ; i-beam
    ("`2" . "¯")    ; macron
    ("`minus" . "¯")    ; macron
    ("`@" . "⍫")    ; del-tilde
    ("`3" . "<")    ; less-than
    ("`#" . "⍒")    ; del-stile
    ("\\gradedown" . "⍒")    ; del-stile
    ("`4" . "≤")    ; less-than-or-equal-to
    ("`leq" . "≤")    ; less-than-or-equal-to
    ("`$" . "⍋")    ; delta-stile
    ("\\gradeup" . "⍋")    ; delta-stile
    ("`5" . "=")    ; equals
    ("`%" . "⌽")    ; circle-stile
    ("\\reverse" . "⌽")    ; circle-stile
    ("\\reversal" . "⌽")    ; circle-stile
    ("\\rotate" . "⌽")    ; circle-stile
    ("`6" . "≥")    ; greater-than-or-equal-to
    ("\\geq" . "≥")    ; greater-than-or-equal-to
    ("`^" . "⍉")    ; circle-backslash
    ("\\transpose" . "⍉")    ; circle-backslash
    ("`7" . ">")    ; greater-than
    ("`&" . "⊖")    ; circled-minus
    ("\\flip" . "⊖")    ; circled-minus
    ("`8" . "≠")    ; not-equal-to
    ("`ne" . "≠")    ; not-equal-to
    ("`*" . "⍟")    ; circle-star
    ("`9" . "∨")    ; logical-or
    ("`or" . "∨")    ; logical-or
    ("`(" . "⍱")    ; down-caret-tilde
    ("`0" . "∧")    ; logical-and
    ("\\and" . "∧")    ; logical-and
    ("`)" . "⍲")    ; up-caret-tilde
    ("`-" . "←")    ; division-sign
    ("\\times" . "×")    ; multiplication-sign
    ("\\signum" . "×")    ; multiplication-sign
    ("`_" . "!")    ; exclamation-mark
    ("`=" . "÷")    ; division-sign
    ("\\div" . "÷")    ; division-sign
    ("`+" . "⌹")    ; quad-divide

    ;; First row
    ("`q" . "?")    ; question-mark
    ("`w" . "⍵")    ; omega
    ("`omega" . "⍵")    ; omega
    ("`W" . "⍹")    ; omega-underbar
    ("`e" . "∊")    ; epsilon
    ("\\epsilon" . "∊")    ; epsilon
    ("\\enlist" . "∊")    ; epsilon
    ("`in" . "∊")    ; epsilon
    ("\\contains" . "∊")    ; epsilon
    ("`E" . "⍷")    ; epsilon-underbar
    ("\\find" . "⍷")    ; epsilon-underbar
    ("\\rho" . "⍴")
    ("\\tile" . "⍴")
    ("\\reshape" . "⍴")
    ("\\shape" . "⍴")
    ("`t" . "∼")    ; tilde
    ("`T" . "⍨")    ; tilde-diaeresis
    ("\\commute" . "⍨")    ; tilde-diaeresis
    ("\\selfie" . "⍨")    ; tilde-diaeresis
    ("\\reflex" . "⍨")    ; tilde-diaeresis
    ("`y" . "↑")    ; uparrow
    ("\\up" . "↑")    ; uparrow
    ("\\mix" . "↑")    ; uparrow
    ("`mix" . "↑")    ; uparrow
    ("\\take" . "↑")    ; uparrow
    ("`Y" . "¥")    ; yen-sign
    ("`u" . "↓")    ; downarrow
    ("\\drop" . "↓")    ; downarrow
    ("\\down" . "↓")    ; downarrow
    ("`i" . "⍳")    ; iota
    ("`iota" . "⍳")    ; iota
    ("`I" . "⍸")    ; iota-underbar
    ("\\where" . "⍸")    ; iota-underbar
    ;; ("`o" . "○")    ; circle
    ("`O" . "⍥")    ; circle-diaeresis
    ("`over" . "⍥")    ; circle-diaeresis
    ;; ("`p" . "⋆")    ; star-operator
    ("`P" . "⍣")    ; star-diaeresis
    ("`power" . "⍣")    ; star-diaeresis
    ("`[" . "←")    ; leftarrow
    ("\\gets" . "←")    ; leftarrow
    ("\\=" . "←")    ; leftarrow
    ("`=" . "←")    ; leftarrow
    ("1=" . "←")    ; leftarrow
    ("<-" . "←")    ; leftarrow
    ("`{" . "⍞")    ; quote-quad
    ("\\quotequad" . "⍞")
    ("\\qq" . "⍞")
    ("`]" . "→")    ; rightarrow
    ("`}" . "⍬")    ; zilde
    ("\\zilde" . "⍬")    ; zilde
    ("\\righttack" . "⊢")
    ("`|" . "⊣")    ; left-tack
    ("`lefttack" . "⊣")    ; left-tack

    ;; Second row
    ("`a" . "⍺")    ; alpha
    ("\\alpha" . "⍺")    ; alpha
    ("`A" . "⍶")    ; alpha-underbar
    ("`s" . "⌈")    ; left-ceiling
    ("\\ceil" . "⌈")    ; left-ceiling
    ("`d" . "⌊")    ; left-floor
    ("\\floor" . "⌊")    ; left-floor
    ("`f" . "_")    ; underscore
    ("`F" . "⍫")    ; del-tilde
    ("`g" . "∇")    ; nabla
    ("\\del" . "∇")    ; nabla
    ("`h" . "∆")    ; increment
    ("`H" . "⍙")    ; delta-underbar
    ;; ("`j" . "∘")    ; ring-operator
    ("`jot" . "∘")    ; ring-operator
    ("\\beside" . "∘")    ; ring-operator
    ("\\compose" . "∘")    ; ring-operator
    ("\\bind" . "∘")    ; ring-operator
    ("`J" . "⍤")    ; jot-diaeresis
    ("\\rank" . "⍤")    ; jot-diaeresis
    ("\\atop" . "⍤")    ; jot-diaeresis
    ;; ("`k" . "'")    ; apostrophe
    ("`K" . "⌺")    ; quad-diamond
    ("\\stencil" . "⌺")    ; quad-diamond
    ;; ("`l" . "⎕")    ; quad
    ("\\quad" . "⎕")    ; quad
    ("`L" . "⌷")    ; squish-quad
    ("\\squad" . "⌷")    ; squish-quad
    ("`;" . "⍎")    ; down-tack-jot
    ("\\execute" . "⍎")    ; down-tack-jot
    ("\\hydrant" . "⍎")    ; down-tack-jot
    ("`:" . "≡")    ; identical-to
    ("`match" . "≡")    ; identical-to
    ("\\depth" . "≡")    ; identical-to
    ("`'" . "⍕")    ; up-tack-jot
    ("\\format" . "⍕")    ; up-tack-jot
    ("`\"" . "≢")   ; not-identical-to
    ("\\tally" . "≢")

    ;; Third row
    ;; ("`z" . "⊂")    ; subset-of
    ("\\enclose" . "⊂")
    ("`x" . "⊃")    ; superset-of
    ("`pick" . "⊃")    ; superset-of
    ("\\first" . "⊃")    ; superset-of
    ("\\disclose" . "⊃")    ; superset-of
    ("`X" . "χ")    ; greek-letter-chi
    ("`c" . "∩")    ; intersection
    ("`C" . "⍧")    ; left-shoe-stile
    ("`v" . "∪")    ; union
    ("`unique" . "∪")    ; union
    ("`b" . "⊥")    ; up-tack
    ("\\decode" . "⊥")    ; up-tack
    ("`B" . "£")    ; pound-sign
    ("`n" . "⊤")    ; down-tack
    ;; ("`m" . "|")    ; divides
    ("`lantern" . "⍝")
    ("`lamp" . "⍝")
    ("`<" . "⍪")    ; comma-bar
    ("`<" . "⍪")    ; comma-bar
    ("\\cove" . "⍪")    ; comma-bar
    ("\\table" . "⍪")    ; comma-bar
    ("`>" . "⍀")    ; backslash-bar
    ("`/" . "⌿")    ; slash-bar
    ("\\slashbar" . "⌿")    ; slash-bar
    ("`?" . "⍠")    ; quad-colon

    ;; Extras (mapped to reasonable keys)
    ("`pi" . "π")   ; pi
    ("`rt" . "√")   ; root
    ("`ie" . "¡")   ; inverted-exclamation-mark
    ("`qb" . "⍂")   ; quad-backslash
    ("`iq" . "¿")   ; inverted-question-mark

    ("`partition" . "⊆") ; subset-of
    ("`key" . "⌸") ; key
    ))

(quail-select-package "apl-dot")
(quail-install-map
 (quail-map-from-table
  '((default apl-dot--transcription-alist))))

(make-comint-in-buffer "J" "*J*" "/opt/homebrew/bin/jconsole")

(with-current-buffer "*J*"
  (setq-local
   comint-input-sender
   (lambda (proc input)
     (comint-send-string proc input)
     (comint-send-string proc "\r"))))

(pop-to-buffer "*J*")
