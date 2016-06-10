;;;; http://codegists.com/snippet/emacs-lisp/naruto-nsel_l3msh0_emacs-lisp
(require 'namespaces)

;; namespace宣言
(namespace naruto
  ;; useはrequireに相当
  :use [dash]
  ;; exportで指定した変数/関数のみ(foo/bar)でアクセスできるようになる
  :export [kill-naruto])

;; defでpriavteな変数宣言(mutableな変数にしたい場合はdefmutableで)
(def PI 3.1415)
(def a 0.05)

;; def, defmutableはnamespace外から値をいじれないためdefcustomで宣言
(defcustom naruto/scale-x 0.3
  "x軸拡大率")

(defcustom naruto/scale-y 0.3
  "y軸拡大率")

;; privateな関数の宣言はdefnで
(defn uzumaki (n)
  "uzumakiのx,y座標をコンスセルで返す"
  (let* ((k (/ n 10.0))
		 (theta (* k (@ PI)))
         (x (* (@ a) theta (cos theta)))
         (y (* (@ a) theta (sin theta))))
    (cons x y)))

(defn get-nth (x y width)
  "座標から配列上の場所を求める"
  (+ x (* y width)))

(defn scale-update (point-alist)
  (mapcar (lambda (point-cell)
            (cons
             (floor (* naruto/scale-x (car point-cell)))
             (floor (* naruto/scale-y (cdr point-cell)))))
          point-alist))

(defn str-update (str x y ox oy)
  "文字を適切なものに変換して返す
ー => 中心からの角度によって文字を変える
英数字 => 半角スペースを足して全角１文字と同じ幅にする"
  (cond ((string= "ー" str)
         (let ((r (_ atan-360 (- y oy) (- x ox))))
										; 角度によって"ー"を変換
           (cond
            ;; |
            ((or (or (and (> 22.5 r)
                          (<= 0 r))
                     (< 337.5 r))
                 (and (<= 157.5 r)
                      (> 202.5 r)))
             "｜")
            ;; ／
            ((or (and (<= 112.5 r)
                      (> 157.5 r))
                 (and (<= 292.5 r)
                      (> 337.5 r)))
             "／")
            ;; ＼
            ((or (and (<= 22.5 r)
                      (> 67.5 r))
                 (and (<= 202.5 r)
                      (> 247.5 r)))
             "＼")
            (t "ー"))))
        ((multibyte-string-p str)
         str)
        (t (format " %s" str))))

(defn atan-360 (y x)
  "atanを度に変化して返す"
  (let ((a (atan y x)))
    (if (< (@ a) 0)
        (+ 360 (/ (* 180 a) (@ PI)))
      (/ (* 180 a) (@ PI)))))

(defn translate (zip-list)
  (let ((min-x (apply #'min (mapcar (lambda (p) (cadr p)) zip-list)))
        (max-y (apply #'max (mapcar (lambda (p) (cddr p)) zip-list)))
        (ox (cadr (first zip-list)))
        (oy (cddr (first zip-list))))
    (mapcar (lambda (p)
              (cons
               (_ str-update (char-to-string (car p)) (cadr p) (cddr p) ox oy)
               (cons
                (+ (abs min-x) (cadr p))
                (- (abs max-y) (cddr p)))))
            zip-list)))

(defn render (zip-list)
  (let* ((max-x (1+ (apply #'max (mapcar (lambda (p) (cadr p)) zip-list))))
         (max-y (1+ (apply #'max (mapcar (lambda (p) (cddr p)) zip-list))))
         (nl (-repeat (* max-x max-y) nil))
         (ox (cadr (first zip-list)))
         (oy (cddr (first zip-list))))
    (-each zip-list (lambda (z)
                      (setf (nth (_ get-nth (cadr z)
									(cddr z)
									max-x)
                                 nl)
                            (car z))))
    (switch-to-buffer "*naruto-render*")
    (erase-buffer)
    (dotimes (y max-y)
      (dotimes (x max-x)
        (let ((mass (nth (_ get-nth x y max-x) nl)))
          (if (null mass)
              (insert "  ")
            (insert mass))
          ))
      (insert "\n"))))

(defn naruto (str)
  "文字列をなると風に変換してバッファに書き出す"
  (let* ((point-alist (mapcar (lambda (k)
                                (let* ((p (_ uzumaki k))
                                       (x (car p))
                                       (y (cdr p)))
                                  (cons (round (* 100 x)) (round (* 100 y)))))
                              (number-sequence 0 (* 2 (length str)) 1)))
         (distinct-list (-take (length str) (-distinct (_ scale-update point-alist))))
         (zip-list (-zip (string-to-list str) distinct-list))
         )
    (_ render (_ translate zip-list))))

(defn kill-naruto (str)
  "なると風に変換した文字列をキルリングにヤンクする"
  (interactive "sString: ")
  (save-window-excursion
    (_ naruto str)
    (with-current-buffer "*naruto-render*"
      (kill-new (buffer-substring-no-properties (point-min) (point-max))))))

;;(_ naruto "あいうえおかきくけこさしすせそーーーーーーーーーーーーーーーーーー")
;; 実行結果
;;                       ー      ー
;;               ／                    ー

;;                                           ＼
;;         ／
;;                                               ＼

;;     ｜
;;                                                 ｜
;;                         かおえう
;;                       き      い
;; ｜                  く        あ                ｜

;;                     け
;;                                               ｜
;;                     こ
;;   ｜
;;                       さ                  ／
;;                         し            そ
;;                               す  せ
;;     ＼



;;             ＼


;;                   ー
;;                               ー