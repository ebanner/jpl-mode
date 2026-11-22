# jpl-mode

APL/BQN glyphic frontend for J

## Highlights

Fixed point scan

```apl
{⍵÷2} ⍣ ⍬ ⊢ 55
```

Power scan with condition

```apl
{⍵÷2} ⍣ {⍵≥1} ⍣ ⍬ ⊢ 10
```

Stencil with no padding

```apl
2 2 < ⌺ ¯3 ⊢ 3 3⍴0
```

Counts

```apl
(↑,≢) ⌸⍨ 1 2 1 2 1
```

Inverse/obverse
```apl
str ← '24:00'

serde ← (60∘⊥) ⍤ ((⍎¨)⇔(⍕˝)) ⍤ ((':'∘chopstring)⇔(':'∘joinstring)) NB. chopstring also works

3 {÷∘⍺⍢serde⍵} str
```
