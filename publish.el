;;; publish.el --- Build the vetr0s.dev blog -*- lexical-binding: t; -*-

(require 'ox-publish)
(require 'python)
(require 'xml)

(defconst vetr0s-blog-root
  (file-name-directory (or load-file-name buffer-file-name)))

(defconst vetr0s-blog-index-file
  (expand-file-name "content/index.org" vetr0s-blog-root))

(defconst vetr0s-blog-url "https://vetr0s.dev")

(let ((htmlize-directory
       (expand-file-name "~/.config/emacs/.local/straight/repos/htmlize/")))
  (when (file-directory-p htmlize-directory)
    (add-to-list 'load-path htmlize-directory)))

(setq org-publish-timestamp-directory
      (expand-file-name ".org-timestamps/" vetr0s-blog-root)
      org-html-htmlize-output-type (and (require 'htmlize nil t) 'css))

(defun vetr0s-blog-publish-to-html (plist filename pub-dir)
  "Publish FILENAME with site navigation outside the site index."
  (let ((options (copy-sequence plist)))
    (unless (file-equal-p filename vetr0s-blog-index-file)
      (setq options
            (plist-put
             options :html-preamble
             "<a class=\"site-name\" href=\"/\">Home</a><hr><h1>%t</h1><p class=\"published\">%d</p>"))
      (setq options (plist-put options :with-title nil))
      (setq options
            (plist-put
             options :html-postamble
             "<a href=\"/\">← All posts</a> · <a href=\"mailto:nate@vetr0s.dev\">Email</a> · <a href=\"https://github.com/vetr0s\">GitHub</a> · <a href=\"https://www.linkedin.com/in/ntebbs\">LinkedIn</a> · <a href=\"/rss.xml\">RSS</a>")))
    (let ((python-indent-guess-indent-offset nil)
          (python-indent-offset 4))
      (org-html-publish-to-html options filename pub-dir))))

(defun vetr0s-blog-post-metadata (filename)
  "Return RSS metadata for the Org post at FILENAME."
  (with-temp-buffer
    (insert-file-contents filename)
    (org-mode)
    (let* ((keywords (org-collect-keywords '("TITLE" "DATE" "DESCRIPTION")))
           (date (cadr (assoc "DATE" keywords)))
           (url (concat vetr0s-blog-url "/posts/"
                        (file-name-base filename) ".html")))
      (list :title (cadr (assoc "TITLE" keywords))
            :description (cadr (assoc "DESCRIPTION" keywords))
            :time (date-to-time (concat date " 00:00"))
            :url url))))

(defun vetr0s-blog-publish-rss ()
  "Write an RSS feed for the blog posts."
  (let* ((posts (sort
                 (mapcar #'vetr0s-blog-post-metadata
                         (directory-files
                          (expand-file-name "content/posts/" vetr0s-blog-root)
                          t "\\.org\\'"))
                 (lambda (a b)
                   (time-less-p (plist-get b :time) (plist-get a :time)))))
         (system-time-locale "C")
         (coding-system-for-write 'utf-8-unix))
    (with-temp-file (expand-file-name "docs/rss.xml" vetr0s-blog-root)
      (insert "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n")
      (xml-print
       (list
        `(rss ((version . "2.0"))
             (channel nil
                      (title nil "Nathan Tebbs")
                      (link nil ,(concat vetr0s-blog-url "/"))
                      (description nil "Notes on software and the things I learn while building.")
                      (lastBuildDate nil ,(format-time-string
                                           "%a, %d %b %Y %H:%M:%S %z"
                                           (plist-get (car posts) :time)))
                      ,@(mapcar
                         (lambda (post)
                           `(item nil
                                  (title nil ,(plist-get post :title))
                                  (link nil ,(plist-get post :url))
                                  (guid ((isPermaLink . "true")) ,(plist-get post :url))
                                  (pubDate nil ,(format-time-string
                                                 "%a, %d %b %Y %H:%M:%S %z"
                                                 (plist-get post :time)))
                                  (description nil ,(plist-get post :description))))
                         posts))))))))

(defun vetr0s-blog-publish (&optional force)
  "Publish the blog.  FORCE rebuilds every file."
  (interactive "P")
  (org-publish "blog" (or force noninteractive))
  (vetr0s-blog-publish-rss))

(setq org-publish-project-alist
      `(("blog-pages"
         :base-directory ,(expand-file-name "content/" vetr0s-blog-root)
         :base-extension "org"
         :publishing-directory ,(expand-file-name "docs/" vetr0s-blog-root)
         :recursive t
         :publishing-function vetr0s-blog-publish-to-html
         :html-doctype "html5"
         :html-html5-fancy t
         :html-head "<link rel=\"stylesheet\" href=\"/style.css\">\n<link rel=\"alternate\" type=\"application/rss+xml\" title=\"Nathan Tebbs\" href=\"/rss.xml\">"
         :html-head-include-default-style t
         :html-head-include-scripts nil
         :html-postamble nil
         :section-numbers nil
         :time-stamp-file nil
         :with-author nil
         :with-creator nil
         :with-toc nil)
        ("blog-static"
         :base-directory ,(expand-file-name "static/" vetr0s-blog-root)
         :base-extension "css\\|ico\\|jpe?g\\|png\\|svg\\|webp"
         :include ("CNAME" ".nojekyll")
         :publishing-directory ,(expand-file-name "docs/" vetr0s-blog-root)
         :recursive t
         :publishing-function org-publish-attachment)
        ("blog"
         :components ("blog-pages" "blog-static"))))

(provide 'vetr0s-blog-publish)
;;; publish.el ends here
