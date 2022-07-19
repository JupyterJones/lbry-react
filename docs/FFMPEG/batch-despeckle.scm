; Takes a pattern and applies despeckle to reduce noise in photos.
; You can also pass ratio if you want to scale photos
;
; CAUTION - IT OVERWRITES EXISTING FILES IN THE DIRECTORY
;
; Example: gimp -i -b '(batch-despeckle "*.jpg" 0.5)' -b '(gimp-quit 0)'

  (define (batch-despeckle pattern ratio)
  (let* ((filelist (cadr (file-glob pattern 1))))
    (while (not (null? filelist))
           (let* ((filename (car filelist))
                  (image (car (gimp-file-load RUN-NONINTERACTIVE
                                              filename filename)))
                  (drawable (car (gimp-image-get-active-layer image)))
                  (cur-width  (car (gimp-image-width image)))
                  (cur-height (car (gimp-image-height image)))
                  (width      (* ratio cur-width))
                  (height     (* ratio cur-height))
                 )
             (plug-in-despeckle RUN-NONINTERACTIVE image drawable 10 3 -1 248)
             (gimp-image-scale image width height)
             (gimp-file-save RUN-NONINTERACTIVE
                             image drawable filename filename)
             (gimp-image-delete image)
            )
           (set! filelist (cdr filelist)))))
           
           
; Ref 1: https://www.gimp.org/tutorials/Basic_Batch/
; Ref 2: http://www.adp-gmbh.ch/misc/tools/script_fu/ex_10.html