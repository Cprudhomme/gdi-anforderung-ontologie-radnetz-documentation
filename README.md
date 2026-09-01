# Radnetz Ontologie Dokumentation (GDI-DE)

Dieses Repository enthält die OWL/RDF-Spezifikation und die automatisierte HTML-Dokumentationspipeline für die **Radnetz-Ontologie** der Geodateninfrastruktur Deutschland (GDI-DE) und des Bundesamtes für Logistik und Mobilität (BALM).

* **Autorin:** Dr. Claire Ponciano
* **Ontologie-Datei:** [`radnetz_ontology.ttl`](radnetz_ontology.ttl)
* **Live-Dokumentation (GitHub Pages):** [https://cprudhomme.github.io/gdi-anforderung-ontologie-radnetz-documentation/](https://cprudhomme.github.io/gdi-anforderung-ontologie-radnetz-documentation/)

---

## Funktionen

* **WIDOCO-Dokumentation:** Vollständige HTML-Dokumentation aller Klassen, Objekteigenschaften, Dateneigenschaften und Codelisten-Individuen.
* **Bilingual:** Unterstützt Deutsch (`de`) und Englisch (`en`).
* **Interaktive Visualisierung (WebVOWL):** Eingebettete grafische Darstellung der Ontologie-Struktur und -Beziehungen.
* **Vollautomatische Veröffentlichung:** Bei jeder Änderung an `radnetz_ontology.ttl` auf dem Branch `main` generiert GitHub Actions die Dokumentation neu und veröffentlicht sie direkt auf GitHub Pages.

---

## Projektstruktur

```text
.
├── .github/
│   └── workflows/
│       └── widoco-documentation.yml    # Automatisierte CI/CD-Pipeline für GitHub Pages
├── .widoco/
│   └── widoco.properties               # WIDOCO-Metadaten & Konfiguration
├── scripts/
│   └── generate_docs.sh                # Lokales Skript zur Dokumentationserstellung
├── radnetz_ontology.ttl                # Radnetz OWL/Turtle-Ontologiedatei
├── .gitignore
└── README.md
```

---

## Automatische Veröffentlichung (GitHub Actions)

Die Dokumentation wird bei jeder Aktualisierung der Ontologie auf dem `main`-Branch automatisch neu erstellt und veröffentlicht:

1. Bearbeiten Sie die Datei `radnetz_ontology.ttl`.
2. Führen Sie einen Commit und Push auf den Branch `main` durch:
   ```bash
   git add radnetz_ontology.ttl
   git commit -m "Update radnetz ontology"
   git push origin main
   ```
3. Der GitHub Actions Workflow [`.github/workflows/widoco-documentation.yml`](.github/workflows/widoco-documentation.yml) wird automatisch ausgelöst:
   - Lädt Java 17 und WIDOCO herunter.
   - Generiert die HTML-Seiten und das WebVOWL-Diagramm.
   - Veröffentlicht das Ergebnis auf GitHub Pages.

> [!IMPORTANT]
> **Einmalige Aktivierung in den GitHub Repository-Einstellungen:**
> Navigieren Sie auf GitHub zu:
> **Settings** → **Pages** → **Build and deployment**
> Wählen Sie unter **Source** die Option **GitHub Actions** aus.

---

## Lokale Dokumentationserstellung

Sie können die Dokumentation auch jederzeit lokal generieren und in der Vorschau betrachten:

### Voraussetzungen
* Ein installiertes Java Development Kit (JDK 11 oder neuer, z.B. via `brew install openjdk`).

### Ausführung
```bash
./scripts/generate_docs.sh
```
Das Skript lädt WIDOCO (falls noch nicht vorhanden) automatisch nach `.widoco/bin/` herunter und erzeugt die Dokumentation im Ordner `docs/`. Öffnen Sie anschließend `docs/index.html` im Webbrowser.
