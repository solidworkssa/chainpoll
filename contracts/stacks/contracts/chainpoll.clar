;; ────────────────────────────────────────
;; ChainPoll v1.0.0
;; Author: solidworkssa
;; License: MIT
;; ────────────────────────────────────────

(define-constant VERSION "1.0.0")

;; Error codes
(define-constant ERR-NOT-AUTHORIZED (err u401))
(define-constant ERR-NOT-FOUND (err u404))
(define-constant ERR-ALREADY-EXISTS (err u409))
(define-constant ERR-INVALID-INPUT (err u422))

;; ChainPoll Clarity Contract
;; On-chain polling and surveys.


(define-map polls
    uint
    {
        question: (string-utf8 256),
        deadline: uint
    }
)
(define-map votes {poll-id: uint, option-id: uint} uint)
(define-data-var poll-nonce uint u0)

(define-public (create-poll (question (string-utf8 256)) (duration uint))
    (let ((id (var-get poll-nonce)))
        (map-set polls id {question: question, deadline: (+ block-height duration)})
        (var-set poll-nonce (+ id u1))
        (ok id)
    )
)

(define-public (vote (poll-id uint) (option-id uint))
    (let ((current (default-to u0 (map-get? votes {poll-id: poll-id, option-id: option-id}))))
        (map-set votes {poll-id: poll-id, option-id: option-id} (+ current u1))
        (ok true)
    )
)

