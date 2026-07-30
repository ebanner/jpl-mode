(replace-regexp-in-string (regexp-quote "⍵") "y" "⍺↑ {:⍤1 ⍋⍨ (≢,⊃) ⌸⍨ ⍵")

(replace-regexp-in-string (regexp-quote "xxx") "y" "⍺↑ {:⍤1 ⍋⍨ (≢,⊃) ⌸⍨ ⍵")

; "{≢ ⍺ ↑ {:⍤1 ⍋⍨ (≢,⊃) ⌸⍨ ⍵}"

; {{ # x{. {: "1 \:~ (#,{.) /.~ y }}

(setq pairs
      '(("⍵" . "y")
        ("⍨" . "~")
        ("⌸" . "./")
        ("⊃" . "{.")
        ("≢" . "#")
        ("⍋" . "\\\\:")
        ("⍤" . "\"")
        ("↑" . "{.")
        ("{:" . "*tail*")
        ;; ("{" . "{{")
        ;; ("}" . "}}")
        ))

(setq apl-str "{⍺↑ {:⍤1 ⍋⍨ (≢,⊃) ⌸⍨ ⍵}")

(pcase-dolist (`(,old . ,new) pairs)
  (setq apl-str (replace-regexp-in-string (regexp-quote old) new apl-str)))

apl-str

