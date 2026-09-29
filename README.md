# Radnetz Ontologie Dokumentation (GDI-DE)

Dieses Repository enthält die OWL/RDF-Spezifikation und die automatisierte HTML-Dokumentationspipeline für die **Radnetz-Ontologie** der Geodateninfrastruktur Deutschland (GDI-DE) und des Bundesamtes für Logistik und Mobilität (BALM).

* **Autorin:** Dr. Claire Ponciano
* **Version:** 2.0.0
* **Ontologie-Datei:** [`radnetz_ontology.ttl`](radnetz_ontology.ttl)
* **Live-Dokumentation (GitHub Pages):** [https://cprudhomme.github.io/gdi-anforderung-ontologie-radnetz-documentation/](https://cprudhomme.github.io/gdi-anforderung-ontologie-radnetz-documentation/)

---

## Funktionen & Neuerungen in v2.0.0

* **Harmonisierte UP-3- und GV2Q-Modellierung:** Vollständige Integration des Radnetz-Datenmodells (GDI-DE UP-3) mit den Destatis GV2Q-Verwaltungseinheiten (Bund, Länder, Regierungsbezirke, Regionen, Kreise, Gemeinden und Reisegebiete).
* **OGC GeoSPARQL & INSPIRE Alignment:** Saubere OWL 2 DL Modellierung unter Verwendung von `geosparql:Geometry`, `geosparql:hasGeometry`, `geosparql:wktLiteral` sowie standardisiertem Alignment zu `inspire-tn-ro:*` (Road Transport Network).
* **Bereinigung von GML/XSD-Artefakten:** Eliminierung redundanter Schemaklassen (z. B. `curvePropertyType`, `pointPropertyType`) zugunsten moderner Linked Open Data Standards.
* **BALM Codelisten-Anbindung:** Semantische Einbindung der kontrollierten Vokabulare des BALM-Registers (`balm-code:*`) für Oberflächenbelag, Führung, Baulast, Richtung, Beleuchtung und Zustand.
* **WIDOCO-Dokumentation:** Interaktive HTML-Dokumentation aller Klassen, Objekteigenschaften und Dateneigenschaften.
* **Bilingual:** Vollständige Unterstützung für Deutsch (`@de`) und Englisch (`@en`).
* **Interaktive Visualisierung (WebVOWL):** Eingebettete grafische Darstellung der Ontologie-Klassenbeziehungen.
* **Vollautomatische CI/CD-Pipeline:** Bei jeder Aktualisierung auf `main` generiert GitHub Actions die Dokumentation automatisch neu und veröffentlicht sie auf GitHub Pages.

---

## Projektstruktur

```text
.
├── .github/
│   └── workflows/
│       └── widoco-documentation.yml    # Automatisierte CI/CD-Pipeline für GitHub Pages
├── .widoco/
│   └── widoco.properties               # WIDOCO-Metadaten & Konfiguration
├── reports/
│   └── wuppertal/                      # Pilot-Mapping & ABox-Daten Wuppertal
│       ├── Radwege_wuppertal_abox.ttl  # ABox Instanzdaten für Wuppertal
│       ├── wuppertal_mapping.yml       # Mapping-Konfiguration
│       └── wuppertal_mapping_report.md # Struktur- und Analysebericht
├── scripts/
│   └── generate_docs.sh                # Lokales Skript zur Dokumentationserstellung
├── radnetz_ontology.ttl                # Radnetz OWL/Turtle-Ontologiedatei (v2.0.0)
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
