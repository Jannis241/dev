# Sinnvolle Default Neovim Keybinds

Diese Keybinds kommen von Vim/Neovim selbst und sind nicht speziell in deiner Config definiert.

## Modi

| Key | Aktion |
| --- | --- |
| `i` | Insert Mode vor Cursor |
| `a` | Insert Mode nach Cursor |
| `I` | Insert am Zeilenanfang |
| `A` | Insert am Zeilenende |
| `o` | Neue Zeile darunter |
| `O` | Neue Zeile darueber |
| `<Esc>` | Zurueck in Normal Mode |
| `v` | Visual Mode |
| `V` | Visual Line Mode |
| `<C-v>` | Visual Block Mode |

## Bewegung

| Key | Aktion |
| --- | --- |
| `h` `j` `k` `l` | Links, runter, hoch, rechts |
| `w` | Zum Anfang des naechsten Wortes |
| `b` | Zum Anfang des vorherigen Wortes |
| `e` | Zum Ende des Wortes |
| `0` | Zum Zeilenanfang |
| `^` | Zum ersten Nicht-Whitespace der Zeile |
| `$` | Zum Zeilenende |
| `gg` | Zum Dateianfang |
| `G` | Zum Dateiende |
| `{` / `}` | Absatz/blockweise hoch/runter |
| `%` | Zum passenden Klammerzeichen |
| `zz` | Aktuelle Zeile zentrieren |

## Suchen

| Key | Aktion |
| --- | --- |
| `/text` | Vorwaerts suchen |
| `?text` | Rueckwaerts suchen |
| `n` | Naechster Treffer |
| `N` | Vorheriger Treffer |
| `*` | Wort unter Cursor vorwaerts suchen |
| `#` | Wort unter Cursor rueckwaerts suchen |

## Editieren

| Key | Aktion |
| --- | --- |
| `x` | Zeichen loeschen |
| `dd` | Zeile loeschen |
| `D` | Bis Zeilenende loeschen |
| `cw` | Wort aendern |
| `ciw` | Inneres Wort aendern |
| `ci"` | Text innerhalb von `"` aendern |
| `ci(` | Text innerhalb von `(` aendern |
| `yy` | Zeile yanken |
| `p` | Nach Cursor einfuegen |
| `P` | Vor Cursor einfuegen |
| `u` | Undo |
| `<C-r>` | Redo |
| `.` | Letzte Aenderung wiederholen |

## Fenster

| Key | Aktion |
| --- | --- |
| `<C-w>s` | Horizontal splitten |
| `<C-w>v` | Vertikal splitten |
| `<C-w>h/j/k/l` | Zwischen Fenstern wechseln |
| `<C-w>q` | Aktuelles Fenster schliessen |
| `<C-w>=` | Fenster gleich gross machen |

## Buffers und Dateien

| Command | Aktion |
| --- | --- |
| `:w` | Speichern |
| `:q` | Schliessen |
| `:wq` | Speichern und schliessen |
| `:e path` | Datei oeffnen |
| `:bnext` | Naechster Buffer |
| `:bprev` | Vorheriger Buffer |
| `:bd` | Buffer loeschen |

## Jumps

| Key | Aktion |
| --- | --- |
| `<C-o>` | Zurueck in der Jump-Liste |
| `<C-i>` | Vorwaerts in der Jump-Liste |
| `gd` | In manchen Setups Go to local declaration; deine Config nutzt `<leader>gd` fuer LSP Definition |
| `mA` | Mark `A` setzen |
| `'A` | Zu Mark `A` springen |

## Registers

| Key | Aktion |
| --- | --- |
| `"ay` | In Register `a` yanken |
| `"ap` | Aus Register `a` pasten |
| `"+y` | In System-Clipboard yanken |
| `"+p` | Aus System-Clipboard pasten |
| `"_d` | Loeschen ohne Register zu ueberschreiben |

Deine Config mappt `<C-y>` auf `"+y` und `<leader>d` auf `"_d`.

