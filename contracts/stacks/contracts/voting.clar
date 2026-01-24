;; ChainPoll - Anonymous Polling (Clarity v4)

(define-data-var poll-nonce uint u0)

(define-map polls
    uint
    {
        creator: principal,
        question: (string-utf8 256),
        end-block: uint,
        option-count: uint,
        active: bool,
        total-votes: uint
    }
)

(define-map poll-options
    {poll-id: uint, option-index: uint}
    (string-utf8 128)
)

(define-map votes
    {poll-id: uint, voter: principal}
    uint
)

(define-map vote-counts
    {poll-id: uint, option-index: uint}
    uint
)

(define-public (create-poll (question (string-utf8 256)) (options (list 10 (string-utf8 128))) (duration uint))
    (let
        (
            (poll-id (var-get poll-nonce))
            (option-count (len options))
        )
        (map-set polls poll-id {
            creator: tx-sender,
            question: question,
            end-block: (+ block-height duration),
            option-count: option-count,
            active: true,
            total-votes: u0
        })
        
        (var-set poll-nonce (+ poll-id u1))
        (ok poll-id)
    )
)

(define-public (cast-vote (poll-id uint) (option-index uint))
    (let
        (
            (poll (unwrap! (map-get? polls poll-id) (err u100)))
            (current-count (default-to u0 (map-get? vote-counts {poll-id: poll-id, option-index: option-index})))
        )
        (asserts! (get active poll) (err u101))
        (asserts! (< block-height (get end-block poll)) (err u102))
        (asserts! (is-none (map-get? votes {poll-id: poll-id, voter: tx-sender})) (err u103))
        
        (map-set votes {poll-id: poll-id, voter: tx-sender} option-index)
        (map-set vote-counts {poll-id: poll-id, option-index: option-index} (+ current-count u1))
        (map-set polls poll-id (merge poll {total-votes: (+ (get total-votes poll) u1)}))
        
        (ok true)
    )
)

(define-read-only (get-poll (poll-id uint))
    (ok (map-get? polls poll-id))
)

(define-read-only (get-vote-count (poll-id uint) (option-index uint))
    (ok (default-to u0 (map-get? vote-counts {poll-id: poll-id, option-index: option-index})))
)
