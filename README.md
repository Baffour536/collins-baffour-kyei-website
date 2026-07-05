# Collins Baffour Kyei — Academic Website

This is a static multi-page academic website. Open `index.html` locally or upload the complete folder to a static host.

## Main pages

- `index.html` — Home
- `about.html` — Academic profile
- `research.html` — Research agenda and software
- `publications.html` — Publications and educational writing
- `teaching.html` — Teaching philosophy and portfolio
- `courses.html` — Course hub and teaching-resource library
- `impact.html` — Academic impact and leadership
- `contact.html` — Contact and collaboration enquiries

## Course level convention

- Course codes beginning with **1** are presented as **First Year**.
- Course codes beginning with **2** are presented as **Second Year**.
- Course codes beginning with **3** are presented as **Third Year**.
- Course codes beginning with **4** are presented as **Fourth Year**.
- Course codes beginning with **8** are presented as **Postgraduate**.

## Course pages

- `course-eco107.html` — ECO 107: Introduction to Computing for Social Scientists
- `course-ecf206.html` — ECF 206: Computer Applications for Financial Economists
- `course-est206.html` — EST 206: Intermediating Computing for Social Scientists
- `course-eco305.html` — ECO 305: Project Appraisal I
- `course-eco306.html` — ECO 306: Project Appraisal II
- `course-eco324.html` — ECO 324: Economics of Capital Markets
- `course-dis814.html` — DIS 814: Data Analysis
- `course-qrm.html` — Postgraduate Quantitative Research Methods

## Adding lecture slides and code later

Every course has its own folder under `assets/courses/<course-slug>/` with these subfolders:

- `slides/` — PowerPoint or PDF lecture slides
- `r/` — `.R` or `.Rmd` files
- `python/` — `.py` or `.ipynb` files
- `data/` — CSV, Excel, SPSS or other teaching datasets
- `practicals/` — exercises, worksheets and worked examples
- `assessments/` — published assignment briefs and revision resources

The current course metadata is also stored in `assets/data/course-manifest.json`.

When a new teaching file is added, place it in the correct course/resource folder and add a public link and description to that course page.

## Course outlines already included

Official Word course outlines supplied for ECO 107, EST 206, ECO 306, ECO 324, DIS 814 and postgraduate Quantitative Research Methods are stored under `assets/docs/course-outlines/` and linked from their pages.

ECF 206 and ECO 305 already have dedicated course/resource pages, but detailed syllabus text is intentionally left for the official outlines rather than being invented. The Level 4 / Fourth Year category is also built into the course hub and is ready for the first fourth-year course once its official details are supplied.
