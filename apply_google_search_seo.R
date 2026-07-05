# Google Search and SEO setup for Collins Baffour Kyei's academic website
# Run this file ONCE from the root Baffour_Website RStudio project.
# It uses only base R and is designed to be safe to re-run.

base_url <- "https://collins-baffour-kyei.netlify.app"

pages <- c(
  "index.html" = "/",
  "about.html" = "/about.html",
  "research.html" = "/research.html",
  "publications.html" = "/publications.html",
  "teaching.html" = "/teaching.html",
  "courses.html" = "/courses.html",
  "impact.html" = "/impact.html",
  "contact.html" = "/contact.html",
  "course-eco107.html" = "/course-eco107.html",
  "course-ecf206.html" = "/course-ecf206.html",
  "course-est206.html" = "/course-est206.html",
  "course-eco305.html" = "/course-eco305.html",
  "course-eco306.html" = "/course-eco306.html",
  "course-eco324.html" = "/course-eco324.html",
  "course-dis814.html" = "/course-dis814.html",
  "course-qrm.html" = "/course-qrm.html"
)

required_files <- names(pages)
missing_files <- required_files[!file.exists(required_files)]

if (length(missing_files) > 0) {
  stop(
    "Run this script from the Baffour_Website project root. Missing files: ",
    paste(missing_files, collapse = ", ")
  )
}

# Create a local backup that Git will ignore.
backup_dir <- file.path(".seo-backup", format(Sys.time(), "%Y%m%d-%H%M%S"))
dir.create(backup_dir, recursive = TRUE, showWarnings = FALSE)

files_to_backup <- c(required_files, "robots.txt", "sitemap.xml")
files_to_backup <- files_to_backup[file.exists(files_to_backup)]
file.copy(files_to_backup, backup_dir, overwrite = TRUE)

if (file.exists(".gitignore")) {
  gitignore <- readLines(".gitignore", warn = FALSE, encoding = "UTF-8")
} else {
  gitignore <- character(0)
}

if (!".seo-backup/" %in% gitignore) {
  writeLines(c(gitignore, ".seo-backup/"), ".gitignore", useBytes = TRUE)
}

read_html <- function(path) {
  paste(readLines(path, warn = FALSE, encoding = "UTF-8"), collapse = "\n")
}

write_html <- function(text, path) {
  writeLines(strsplit(text, "\n", fixed = TRUE)[[1]], path, useBytes = TRUE)
}

remove_managed_block <- function(html) {
  gsub(
    "(?s)\\n?<!-- GOOGLE-SEARCH-SEO-START -->.*?<!-- GOOGLE-SEARCH-SEO-END -->\\n?",
    "\n",
    html,
    perl = TRUE
  )
}

insert_before_head_close <- function(html, block) {
  if (!grepl("</head>", html, fixed = TRUE)) {
    stop("No </head> tag found.")
  }
  sub(
    "</head>",
    paste0(block, "\n</head>"),
    html,
    fixed = TRUE
  )
}

profile_schema <- paste(
"{",
"  \"@context\": \"https://schema.org\",",
"  \"@graph\": [",
"    {",
"      \"@type\": \"WebSite\",",
"      \"@id\": \"https://collins-baffour-kyei.netlify.app/#website\",",
"      \"url\": \"https://collins-baffour-kyei.netlify.app/\",",
"      \"name\": \"Collins Baffour Kyei\",",
"      \"alternateName\": \"Collins Baffour Kyei Academic Portfolio\"",
"    },",
"    {",
"      \"@type\": \"ProfilePage\",",
"      \"@id\": \"https://collins-baffour-kyei.netlify.app/#profilepage\",",
"      \"url\": \"https://collins-baffour-kyei.netlify.app/\",",
"      \"name\": \"Collins Baffour Kyei | Economist, Researcher & Educator\",",
"      \"isPartOf\": {",
"        \"@id\": \"https://collins-baffour-kyei.netlify.app/#website\"",
"      },",
"      \"mainEntity\": {",
"        \"@id\": \"https://collins-baffour-kyei.netlify.app/#person\"",
"      }",
"    },",
"    {",
"      \"@type\": \"Person\",",
"      \"@id\": \"https://collins-baffour-kyei.netlify.app/#person\",",
"      \"name\": \"Collins Baffour Kyei\",",
"      \"url\": \"https://collins-baffour-kyei.netlify.app/\",",
"      \"image\": \"https://collins-baffour-kyei.netlify.app/assets/images/hero.webp\",",
"      \"description\": \"Economist, doctoral researcher, university lecturer and machine learning enthusiast working at the intersection of macroeconomics, financial economics, data science and evidence-informed public engagement.\",",
"      \"jobTitle\": \"Economist, Researcher & Educator\",",
"      \"affiliation\": {",
"        \"@type\": \"CollegeOrUniversity\",",
"        \"name\": \"University of Cape Coast\"",
"      },",
"      \"sameAs\": [",
"        \"https://orcid.org/0000-0002-4506-1865\",",
"        \"https://scholar.google.com/citations?hl=en&user=XPsgargAAAAJ\",",
"        \"https://www.linkedin.com/in/collins-baffour-kyei-443239176\",",
"        \"https://www.youtube.com/@Bafcoll\"",
"      ],",
"      \"knowsAbout\": [",
"        \"Macroeconomics\",",
"        \"Monetary Economics\",",
"        \"Financial Economics\",",
"        \"Inflation Dynamics\",",
"        \"Econometrics\",",
"        \"Data Science\",",
"        \"Machine Learning\",",
"        \"Quantile Methods\",",
"        \"Wavelet Analysis\",",
"        \"Time-Series Econometrics\",",
"        \"Research Software\",",
"        \"Data Literacy\"",
"      ]",
"    }",
"  ]",
"}",
  sep = "\n"
)

for (file in names(pages)) {
  path <- pages[[file]]
  canonical_url <- paste0(base_url, path)

  html <- read_html(file)
  html <- remove_managed_block(html)

  # Remove any older canonical/meta tags that could duplicate the managed SEO block.
  html <- gsub(
    "(?i)<link\\s+[^>]*rel=[\"']canonical[\"'][^>]*>\\s*",
    "",
    html,
    perl = TRUE
  )
  html <- gsub(
    "(?i)<meta\\s+[^>]*name=[\"']robots[\"'][^>]*>\\s*",
    "",
    html,
    perl = TRUE
  )
  html <- gsub(
    "(?i)<meta\\s+[^>]*property=[\"']og:url[\"'][^>]*>\\s*",
    "",
    html,
    perl = TRUE
  )
  html <- gsub(
    "(?i)<meta\\s+[^>]*property=[\"']og:site_name[\"'][^>]*>\\s*",
    "",
    html,
    perl = TRUE
  )

  seo_lines <- c(
    "<!-- GOOGLE-SEARCH-SEO-START -->",
    paste0('<link rel="canonical" href="', canonical_url, '">'),
    '<meta name="robots" content="index, follow">',
    paste0('<meta property="og:url" content="', canonical_url, '">'),
    '<meta property="og:site_name" content="Collins Baffour Kyei">'
  )

  if (identical(file, "index.html")) {
    seo_lines <- c(
      seo_lines,
      '<script type="application/ld+json" id="profile-schema">',
      profile_schema,
      "</script>"
    )
  }

  seo_lines <- c(seo_lines, "<!-- GOOGLE-SEARCH-SEO-END -->")
  seo_block <- paste(seo_lines, collapse = "\n")

  html <- insert_before_head_close(html, seo_block)

  # Public website policy: keep the PDF CV public; remove Word CV links.
  html <- gsub(
    "(?is)<a\\b[^>]*href=[\"']assets/docs/Collins_Baffour_Kyei_Academic_CV_2026\\.docx[\"'][^>]*>.*?</a>",
    "",
    html,
    perl = TRUE
  )

  # Correct a grammar issue currently present on the homepage.
  if (identical(file, "index.html")) {
    html <- gsub(
      "and I documents them separately",
      "and I document them separately",
      html,
      fixed = TRUE
    )
  }

  write_html(html, file)
  message("SEO updated: ", file, " -> ", canonical_url)
}

# Create the XML sitemap.
sitemap_lines <- c(
  '<?xml version="1.0" encoding="UTF-8"?>',
  '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">'
)

for (file in names(pages)) {
  loc <- paste0(base_url, pages[[file]])
  sitemap_lines <- c(
    sitemap_lines,
    "  <url>",
    paste0("    <loc>", loc, "</loc>"),
    "  </url>"
  )
}

sitemap_lines <- c(sitemap_lines, "</urlset>")
writeLines(sitemap_lines, "sitemap.xml", useBytes = TRUE)

# Allow crawling and advertise the sitemap.
robots_lines <- c(
  "User-agent: *",
  "Allow: /",
  "",
  paste0("Sitemap: ", base_url, "/sitemap.xml")
)
writeLines(robots_lines, "robots.txt", useBytes = TRUE)

cat(
  "\nGoogle Search SEO setup completed successfully.\n",
  "Updated HTML pages: ", length(pages), "\n",
  "Created/updated: sitemap.xml\n",
  "Created/updated: robots.txt\n",
  "Added: self-referencing canonical URLs\n",
  "Added: index/follow robots meta tags\n",
  "Added: per-page og:url and consistent og:site_name\n",
  "Added: WebSite + ProfilePage + Person JSON-LD on index.html\n",
  "Removed: public Word CV links; PDF CV links are unaffected\n",
  "Fixed: homepage grammar 'I documents' -> 'I document'\n",
  "Backup: ", backup_dir, "\n\n",
  "Next Git commands:\n",
  "git status\n",
  "git add .\n",
  'git commit -m "Add sitemap and Google Search SEO metadata"\n',
  "git push\n",
  sep = ""
)
