extensions [profiler]

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Globals
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

globals [price_t price_t-1 real_price firms_list investors_list

  s_price_list s_price_list_temp
  s_price_hist

  return_list_t-1 return_list
  esembled_average_t-1 esembled_average
  stddev_rt_1 stddev_rt
  newpricelog
  return
  making_order

  share_volume
  share_volume_all

  dividends_all

  order_bank
  order_bank_all

  action_bank_all
  temp2
  index
  directory_name
  margin_100
  mr_catch
  offender
  r_effort_off
  cap_off
  gr_off
  cap_neg
  mb_off
  earnings
  eg_of_mkt   ;; earning growth
  mkt_PE

  grow_e
  grow_i      ;; growth of the index
  met_exp
  pop_change_exp

  ;; can go back to let
  newprice
  neg
  count_investors

  hitall
]

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Breeds/Classes
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

breed [firms firm]
breed [investors investor]

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Ownership
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

firms-own
[ firm_ID
  capital_i   cap_t-1
  profit      profit_t-1
  qty
  price_real
  revenue     revenue_t-1
  costs       costs_t-1
  margin      margin_t-1       esemble_margin_t-1
  roic        roic_t-1
  dividend

  mr   ;; can go once calibrated (back to let)
  gr   ;;  can go once calibrated (back to let)

  growth_y                      ;;; what type of firm
  expectation
  met_p_e_y
  pex_gap                      ;;; private expectation miss
  miss_count                   ;;;
                               ;;;;;;;
  hit1
  hit2
  hit3
  hit4
  hit5
  hit6
  hit7
  hit8

  ;;;;;;;
  change_exp
  r_effort                     ;;; revenue effort
  m_effort                     ;;; margin effort
  mgm                          ;;; convert back to let

  mgmt_ability
  std                          ;;; the std for normal dist for who actual effort changes with the effort employed - NB parameters.xls contains the cal
  reinv ;; reinvestment rate

  exp_changes_+
  exp_changes_-

  es_earnings esemble_earnings_t-1
  e_growth     es_earnings_grow    esemble_earnings_g_t-1
  r_growth     es_revenue_grow     esemble_revenue_g_t-1
  m_growth     es_margin_grow
  esemble_capital_t-1              es_capital_base
  roic_growth

  s_price
  non_log_rti_a
  hist
  moving_s_price

  PE_ratio
  PB_ratio
  peg_f

  ;bid_vol
  ;ask_vol
  rti
  a_rt
  stdevrt

  ;return back to let
  ;newprice
  olda  ;;; needs to go

  rev_m15   cap_m15   earn_m15
  rev_m10   cap_m10   earn_m10
  rev_m5    cap_m5    earn_m5
  rev_m3    cap_m3    earn_m3
  rev_m1    cap_m1    earn_m1

  ;; variables that have to go in for data analysis
  gro_pr
  pri_con
  mw_f

]

investors-own
[ investor_ID
  kind
  portfolio
  cash
  memory
  portfolio_value_i
  portfolio_value
  ownership_pro
  portfolio_value_history
  port_return_history
  portfolio_return
  trades      ;; array of volume of trades
  actions     ;; array of buy (1), hold (0), and sell (-1)


  decision_score
  convinction
  cpx
  pegr
  dividends_received
  div_har
  mw_i
]


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Set Up
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

to set_up
  clear-all
  set directory_name "/users/matthewoldham/Dropbox/Dissertation/Flip/Results"
  fill_globals
  create_firms
  create_investors
  fill_shares
  reset-ticks
end


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; fill globals
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

to fill_globals

  set price_t 1                                 ;;;;;     start at 1
  set real_price 1                              ;;;;;     just starting at 1 but no influence here
  set s_price_list []
  set s_price_hist []

  set making_order []
  set return_list []
  set return_list_t-1 []
  set esembled_average_t-1 []
  set esembled_average []
  set stddev_rt_1 []
  set stddev_rt []
  set share_volume []
  ;set stdevpr_list []
  ;set avepr_list []

  let p 0
  while [ p < num_firms ]
    [
      set esembled_average lput 0 esembled_average
      set stddev_rt lput 0.1 stddev_rt  ;; problem early may be for first move   0 or 1?????
      set return_list lput 0 return_list
      set p (p + 1)
  ]

  if chartist_earnings = TRUE   [set count_investors count_investors + 1 ]
  if chartist_price = TRUE   [set count_investors count_investors + 1 ]
  if fund_peg = TRUE   [set count_investors count_investors + 1 ]
  if fund_pe = TRUE  [set count_investors count_investors + 1 ]
  if fund_value = TRUE [set count_investors count_investors + 1]

end
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; create firms
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

to create_firms

  let c 0
  while[c < num_firms]
  [
    create-firms 1
    [
      set firm_id who
      set hist []
      set making_order lput firm_id making_order
      set growth_y false
      set mgmt_ability random-normal ave_ability .05

      set cap_t-1 capital
      set expectation .1 + random-float .7             ;;;

      ;;;;;;;; market stuff


      set a_rt []
      set stdevrt []
    ]
    set c (c + 1)
  ]

  ask n-of (num_firms * growth_pro)  firms
  [
    set growth_y true
  ]

  ask firms [

    allocate_effort                               ;;;;;  goes off to set expectations and returns effort

    set qty (r_effort) * mgmt_ability * capital
    set revenue qty    ;;;; took the 1 + r_effort out (consisent with profits call 26/6

    let fc (capital_i * (interest_rate / 10))

    ;[set mr g * (1 + (mgm / mgmt_ability))  ]


    ;  let vc qty * (1 - ((mr * interest_rate) * m_effort ))

    let vc qty * (1 - ((g * interest_rate) * m_effort ))      ;;; where effort comes in

    set costs (fc + vc)

    set profit revenue - costs                   ;;;;;  this is not a great start with 0 profits....
    set margin profit / revenue
    set roic profit / cap_t-1
    set capital_i cap_t-1 + profit

    set es_capital_base (memory_weight * 1) + (1 - memory_weight) * capital_i

    ifelse growth_y = true

    [
      let rg-n-1 (-.2 + random-float .4)
      let rg_es (-.2 + random-float .4)
      set es_revenue_grow (memory_weight * rg_es) + (1 - memory_weight) * rg-n-1

      let eg_n-1 (-.1 + random-float .2)
      let eg_es (-.1 + random-float .2)
      set es_earnings_grow (memory_weight * eg_es) + (1 - memory_weight) * eg_n-1
      set pe_ratio random-normal 20 1

    ]
    [
      let rg-n-1 (-.1 + random-float .2)
      let rg_es (-.1 + random-float .2)
      set es_revenue_grow (memory_weight * rg_es) + (1 - memory_weight) * rg-n-1

      let eg_n-1 (-.1 + random-float .2)
      let eg_es (-.1 + random-float .2 )
      set es_earnings_grow (memory_weight * eg_es) + (1 - memory_weight) * eg_n-1
      set pe_ratio random-normal 16 1

    ]

    let s_p_n-1 ((profit / (4 * count_investors)) * pe_ratio)    ;;;;
    set s_price ((profit / (4 * count_investors)) * pe_ratio)  ;;;;   really needs to be the in the range
    set moving_s_price (memory_weight * s_p_n-1)   + (1 - memory_weight) * s_price
    set hist lput s_price hist
    set PB_ratio (s_price * (4 * count_investors)) / capital_i

    set rev_m15 0  set cap_m15 0 set earn_m15 0
    set rev_m10 0  set cap_m10 0 set earn_m10 0
    set rev_m5  0  set cap_m5 0  set earn_m5 0
    set rev_m3  0  set cap_m3 0  set earn_m3 0
    set rev_m1  0  set cap_m1 0  set earn_m1 0

    set gro_pr growth_pro
    set pri_con price_concern
    set mw_f memory_weight
  ]

  set firms_list [who] of firms
  set firms_list sort firms_list

  let f 0
  while [f < num_firms]
  [ let p [s_price] of firm f
    let q [hist] of firm f
    set s_price_list lput p s_price_list
    set s_price_hist lput q s_price_hist
    set f (f + 1)
  ]

  ;; in order
  ; let o 0

  set index sum s_price_list / num_firms
  set earnings sum [profit] of firms

end
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; create investors
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

to create_investors

  if chartist_earnings = TRUE   [breed_investor_ce ]
  if chartist_price = TRUE   [breed_investor_cp ]
  if fund_peg = TRUE   [breed_investor_fe ]
  if fund_pe = TRUE  [breed_investor_fp ]
  if fund_value = TRUE [breed_investor_pb]

  set investors_list [who] of investors
  set investors_list sort investors_list

end

to breed_investor_ce
  create-investors 1 [
    set kind "ce"
    fill_investor
  ]
end

to breed_investor_cp
  create-investors 1 [
    set kind "cp"
    fill_investor
  ]
end

to breed_investor_fe
  create-investors 1 [
    set kind "fe"
    fill_investor
  ]
end

to breed_investor_fp
  create-investors 1 [
    set kind "fp"
    fill_investor
  ]
end

to breed_investor_pb
  create-investors 1 [
    set kind "pb"
    fill_investor
  ]
end

to fill_investor

  setxy -15 15
  set cash (num_firms * 1)     ;;;; cash was 1 for 1 asset but now 1000 assets. Too much cash too much buying   match price
  set portfolio []
  set portfolio_value_i []
  set div_har []
  set actions []
  set trades []
  set portfolio_value_history []
  set port_return_history []
  set ownership_pro []
  set convinction []
  set cpx []
  set mw_i memory_weight

  let p 0
  while [ p < num_firms ]
  [
    set portfolio lput 4 portfolio                ;;; why 4???
    set portfolio_value_i lput 4 portfolio_value_i
    set actions lput 0 actions
    set trades lput 0 trades
    set p (p + 1)
  ]
  set portfolio_value cash + sum portfolio_value_i
  set portfolio_value_history lput portfolio_value portfolio_value_history

end

to fill_shares
  set  share_volume []
  set share_volume_all []
  set share_volume_all [portfolio] of investors

  ; set buying_list []
  ; set selling_list []
  ; set action_bank_all []
  ; set action_bank_all [actions] of investors

  let x 0
  while [ x < num_firms ]
  [ let temp sum map [ ?1 -> item x ?1 ] share_volume_all
    set share_volume lput temp share_volume
    set x (x + 1)
  ]

end
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; steps
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

to step

  ;;;; Management steps
  ask firms [set exp_changes_+ 0  set exp_changes_- 0]
  set pop_change_exp 0
  ;pricing_share_count
  profits

  ;;;; Investor steps
  ; assess_results
  order_formation    ;; agents call assess_results from here

  ;;;; Market
  order_book
  clear_market

  ;;; Update investors
  investor_update
  portfolio_valuation
  fill_shares
  investors_pro

  ;;; back to management to adjust
  if price_concern = 0 [adjust_expectations]
  if price_concern != 0 [influence]


  jack_investors
  tick
end


to go
  if ticks > stop_after [
     export-world (word "test" date-and-time ".csv")
    stop]
  if neg > 0 [stop]

  ; profiler:start
  step
  ; profiler:stop
  ;print profiler:report
  ;profiler:reset

  if ticks + 100 = stop_after [ask firms [
    set rev_m15 revenue
    set cap_m15 capital_i
    set earn_m15 profit
  ]]

  if ticks + 50 = stop_after [ask firms [
    set rev_m10 revenue
    set cap_m10 capital_i
    set earn_m10 profit
  ]]

  if ticks + 25 = stop_after [ask firms [
    set rev_m5 revenue
    set cap_m5 capital_i
    set earn_m5 profit
  ]]

  if ticks + 10 = stop_after [ask firms [
    set rev_m3 revenue
    set cap_m3 capital_i
    set earn_m3 profit
  ]]

  if ticks + 5 = stop_after [ask firms [
    set rev_m1 revenue
    set cap_m1 capital_i
    set earn_m1 profit
  ]]

end

to allocate_effort


  ;;;;;;;;;;;;; All growth firms set the allocation of effort

  ifelse growth_y = true

  [ let l (1 / (1 + (( 1 / expectation ) - 1 ) * exp(- expectation)) * .5)
    ifelse l = 0
    [set r_effort .5
      set m_effort 1 - r_effort
      set std 0.001 + ((1 - (r_effort * 2)) * -0.025)
      set reinv exp(1 - (1 / (r_effort ^ 2)))]
    [
      set r_effort .499 + l             ;;;; just to take the extremes out
      set m_effort 1 - r_effort
      set std 0.001 + ((1 - (r_effort * 2)) * -0.025)
      set reinv exp(1 - (1 / (r_effort ^ 2)))
    ]
  ]

  ;;;;;;;;;;;;; All margin  firms set the allocation of effort

  [
    let l (1 / (1 + (( 1 / expectation ) - 1 ) * exp(- expectation)) * .5)
    ifelse l = 0
    [
      set m_effort .5
      set r_effort 1 - m_effort
      set std 0.001 + ((1 - (m_effort * 2)) * -0.025)
      set reinv interest_rate + (.15 * (m_effort ^ 1.5))
    ]
    [
      set m_effort .499 + l               ;;;; just to take the extremes out
      set r_effort 1 - m_effort
      set std 0.001 + ((1 - (m_effort * 2)) * -0.025)   ;;;; crictical point is that the standard deviation needs to reflect on margins here
      set reinv interest_rate + (.15 * (m_effort ^ 1.5))
    ]
  ]

end



to profits
  ask firms [

    set price_real random-normal 1 .02
    set profit_t-1 profit
    set cap_t-1 capital_i
    set revenue_t-1 revenue
    set costs_t-1 costs
    ifelse margin <= 0
    [ set margin_t-1  .001   ]
    [set margin_t-1 margin]
    set roic_t-1 roic

    ;; mgmt_ability is bounded between

    ;; set managements return for the period

    set mgm mgmt_ability * (1 + (random-normal 0 std))

    ;;;;;;;;  set revenue

    ifelse growth_y = true
    [set gr mgm]
    [set gr mgmt_ability]

    if gr < 0 [stop]                                                        ;;;;;
    set qty (r_effort * (mgm /  mgmt_ability)) * capital_i            ;;;;; is it 1 + r_effort or just r_effort

    set revenue qty * price_real   ; may be quantity here as E(P) = 1 and added penalty for not getting price. Not quanity

    ;;;; set costs per unit

    ifelse growth_y = true       ;  g is the effective return factor (see parameters.xls for why 20) Ref???
    [set mr g]
    [set mr g * (mgm / mgmt_ability)  ]         ;;;

    let fc (capital_i * (interest_rate / 10))
    let vc qty * (1 - ((mr * interest_rate) * m_effort ))      ;;; where effort comes in

    set costs (fc + vc)
    set profit (revenue - costs)    ;; but es_earnings

    ifelse profit > 0
    [set capital_i cap_t-1 + (profit * reinv)
      set dividend ((profit * (1 - reinv)) * .60) * market_depth ]                ;; re-investment  *** This is about increasing investing

    [set capital_i cap_t-1 + profit  ]                         ;; had assumed that profits would always be positive

    if capital_i < 0 [set cap_neg cap_neg + 1]   ;; why only 1?  so no bankrupt firms....no bankrupt firms, just very small ones.....


    set margin profit / revenue
    if margin > 1 [set margin_100 margin_100 + 1
      set mr_catch mr
      set offender who
      set cap_off capital_i
      set r_effort_off r_effort
      set gr_off gr
      set mb_off mgmt_ability
    ]

    set roic profit / cap_t-1

    ;;;;;;;;;;;;;;;  update growth
    ; moving_s_price (memory_weight * moving_s_price)   + (1 - memory_weight) * newprice

    set e_growth (profit / profit_t-1) - 1
    set r_growth (revenue / revenue_t-1) - 1
    set m_growth (margin /  margin_t-1)  - 1
    set roic_growth (roic / roic_t-1) - 1

    ifelse growth_y = true
    [ifelse r_growth >= expectation
      [set met_p_e_y true
        set pex_gap r_growth - expectation
        if pex_gap > 1 [set pex_gap  1]
        if pex_gap < -1 [set pex_gap  -1]
        set miss_count 0]
      [set met_p_e_y false
        set pex_gap r_growth - expectation
        if pex_gap > 1 [set pex_gap  1]
        if pex_gap < -1 [set pex_gap  -1]
        set miss_count (miss_count + 1)]
    ]
    [ifelse m_growth >= expectation
      [set met_p_e_y true
        set pex_gap m_growth - expectation
        if pex_gap > 1 [set pex_gap  1]
        if pex_gap < -1 [set pex_gap  -1]
        set miss_count 0]
      [set met_p_e_y false
        set pex_gap m_growth - expectation
        if pex_gap > 1 [set pex_gap  1]
        if pex_gap < -1 [set pex_gap  -1]
        set miss_count (miss_count + 1)]
    ]

    set esemble_margin_t-1 es_margin_grow
    set esemble_earnings_g_t-1 es_earnings_grow
    set esemble_revenue_g_t-1 es_revenue_grow
    set esemble_earnings_t-1 es_earnings
    set esemble_capital_t-1 es_capital_base

    ifelse ticks < 2 [set es_margin_grow m_growth]

    [
      set es_margin_grow (memory_weight * esemble_margin_t-1) + (1 - memory_weight) *  m_growth
    ]
    set es_earnings_grow (memory_weight * esemble_earnings_g_t-1) + (1 - memory_weight) * e_growth
    set es_revenue_grow (memory_weight * esemble_revenue_g_t-1) + (1 - memory_weight) * r_growth
    set es_earnings (memory_weight * esemble_earnings_t-1) + (1 - memory_weight) * profit
    set es_capital_base (memory_weight * esemble_capital_t-1) + (1 - memory_weight) * capital_i


    set PE_ratio s_price / (es_earnings / (4 * count investors))             ;;;;  why isnot this divided by number of shares?????
    set peg_f PE_ratio / (es_earnings_grow * 100)
    set PB_ratio (s_price * (4 * count investors)) / es_capital_base           ;;;; changed to es_capital_base from just the capital base
  ]
end


to order_formation                                                ;;;; trades = key variable strong buy 2 strong selling -2 therefore .5 for each investotr
  ask investors
  [
    assess_results     ;;;;;;  can may be change so global

    set trades []
    let d 0
    while [ d < num_firms ]

    [
      let stock_price item d s_price_list
      let holding item d portfolio
      let act item d actions
      let con item d convinction

      if act > 0
      [
        ifelse cash > 0

        [
          let trans (1 / num_firms) * transaction_ratio * con  * cash      ;;; cash is the interesting thing here
          if trans > 2.5 [set trans 2.5]               ;;;;;;;;;;   trouble spot
          set trades lput trans trades
        ]
        [set trades lput 0 trades ]
      ]

      if act < 0
        [
          ifelse holding > 0 [
            let trans (transaction_ratio * con * holding ) * -1
            set trades lput trans trades    ;;; need to balance this with buying
          ]
          [ set trades lput 0 trades  ]
      ]

      if act = 0 [
        set trades lput 0 trades
      ]
      set d (d + 1)
    ]
  ]
end


to assess_results

  ask investors
  [
    set actions []
    set convinction []

    if kind =  "fp"
    [
      let fud 0
      while [fud < num_firms]
      [
        if [growth_y] of firm fud = true [

          set pegr [PE_ratio] of firm fud              ; crgn = chartist revenue growth n
          if pegr > 100 [set pegr 100]
          if pegr < 1 [set pegr 1 ]

          if pegr >= 25 [set decision_score -1]
          if (pegr < 25) and (pegr >= 20)  [set decision_score 0]
          if pegr < 20 [set decision_score 1 ]

          set actions lput decision_score actions

          if decision_score = 0 [ set convinction lput 0 convinction]

          if decision_score = 1
          [
            set pegr (1 / pegr)
            let con (pegr - .04) / (1 - .04)          ;;;; needs to be 1/25  ie .05
            set convinction lput con convinction
          ]

          if decision_score = -1
          [
            ;set pegr (1 / pegr)
            let con (pegr - 25) / (100 - 25)             ;;   25 not 20
            set convinction lput con convinction
          ]
        ]

        if [growth_y] of firm fud = false [

          set pegr [PE_ratio] of firm fud
          if pegr > 100 [set pegr 100]
          if pegr < 1 [set pegr 1 ]              ; crgn = chartist revenue growth n

          if pegr >= 18 [set decision_score -1]
          if (pegr < 18) and (pegr >= 14) [set decision_score 0]
          if pegr < 14 [set decision_score 1]

          set actions lput decision_score actions

          ;; to normalise this stuff
          ;; xi - min(x)) / (max(x) - min(x))

          if decision_score = 0 [ set convinction lput 0 convinction]

          if decision_score = 1
          [
            set pegr (1 / pegr)
            let con (pegr - ( 1 / 18) ) / (1 - ( 1 / 18))
            set convinction lput con convinction
          ]
          if decision_score = -1
          [
            ;set pegr (1 / pegr)
            let con (pegr - 18) / (100 - 18)
            set convinction lput con convinction
          ]
        ]
        set fud (fud + 1)
      ]
    ]

    if kind = "cp"
    [
      set cpx []
      let chp 0
      while [chp < num_firms]
      [
        let cpn [s_price] of firm chp                   ;cpn = chartist price n
        let c_ave_p [moving_s_price] of firm chp        ;c_ave_p = chartist moving average price

        let p_r_ma cpn / c_ave_p
        if p_r_ma > 4 [set p_r_ma 4]
        if p_r_ma < .25 [set p_r_ma .25]

        if p_r_ma <= .99 [set decision_score -1]
        if (p_r_ma > .99) and (p_r_ma < 1.01) [set decision_score 0]
        if p_r_ma >= 1.01 [set decision_score 1]

        set actions lput decision_score actions

        if decision_score = 0 [
          let noise -.05 + random-float .1
          if noise < 0
          [set actions replace-item chp actions -1
            set convinction lput (-1 * noise) convinction]

          if noise > 0
          [set actions replace-item chp actions 1
            set convinction lput noise convinction]
        ]

        if decision_score = 1
        [
          let con (p_r_ma - 1) / (4 - 1)
          set convinction lput con convinction
        ]

        if decision_score = -1 [
          set p_r_ma (1 / p_r_ma)
          let con (p_r_ma - 1) / (4 - 1)
          set convinction lput con convinction
        ]
        set chp (chp + 1)
      ]
    ]

    if kind =  "fe"      ;;; kill use roic
    [
      let fe 0
      while [fe < num_firms][

        let fpn [pe_ratio] of firm fe
        let eg ([es_earnings_grow] of firm fe * 100)
        if eg <= 0 [set eg .0001]

        let peg fpn / eg
        if peg > 4 [set peg 4]
        if peg < .25 [set peg .25]

        ifelse [growth_y] of firm fe = true

        [ if peg >= 1.03 [set decision_score -1]
          if (peg < 1.03) and (peg > .99) [set decision_score 0]
          if peg  <= .99 [set decision_score 1]

          set actions lput decision_score actions
          if decision_score = 1 [set peg (1 / peg)]

          let con (peg - .25) / (4 - .25)
          set convinction lput con convinction
        ]

        [ if peg >= 1.02 [set decision_score -1]
          if (peg < 1.02) and (peg >= .98) [set decision_score 0]
          if peg  <= .98 [set decision_score 1]

          set actions lput decision_score actions
          if decision_score = 1 [set peg (1 / peg)]

          let con (peg - .25) / (4 - .25)
          set convinction lput con convinction
        ]
        set fe (fe + 1)
      ]
    ]

    if kind = "ce"
    [
      let ce 0
      while [ce < num_firms][

        if [growth_y] of firm ce = true [

          let crgn [r_growth] of firm ce              ; crgn = chartist revenue growth n
          let c_ave_r [es_revenue_grow] of firm ce

          let e_r_ma crgn / c_ave_r
          if e_r_ma > 4 [set e_r_ma 4]
          if e_r_ma < .25 [set e_r_ma .25]

          if e_r_ma <= .99 [set decision_score -1]
          if (e_r_ma > .99) and (e_r_ma < 1.01) [set decision_score 0]
          if e_r_ma >= 1.01 [set decision_score 1]

          set actions lput decision_score actions

          if decision_score = 0 [ set convinction lput 0 convinction]

          if decision_score = -1
          [
            set e_r_ma (1 / e_r_ma)
            let con (e_r_ma - 1) / 6
            set convinction lput con convinction
          ]

          if decision_score = 1
            [
              let con (e_r_ma - 1) / 3
              set convinction lput con convinction
          ]
        ]
        if [growth_y] of firm ce = false [

          let cmgn [m_growth] of firm ce              ; crgn = chartist margin growth n
          let c_ave_m [es_margin_grow] of firm ce

          let m_r_ma cmgn / c_ave_m
          if m_r_ma > 4 [set m_r_ma 4]
          if m_r_ma < .25 [set m_r_ma .25]

          if m_r_ma <= .99 [set decision_score -1]
          if (m_r_ma > .99) and (m_r_ma < 1.10) [set decision_score 0]
          if m_r_ma >= 1.01 [set decision_score 1]

          set actions lput decision_score actions

          if decision_score = 0 [ set convinction lput 0 convinction]

          if decision_score =  1 [
            let con (m_r_ma - 1) / 3   ;;;
            set convinction lput con convinction
          ]

          if decision_score = -1 [
            set m_r_ma (1 / m_r_ma)
            let con (m_r_ma - 1) / 6
            set convinction lput con convinction
          ]
        ]
        set ce (ce + 1)
      ]
    ]

    if kind =  "pb"
    [
      let fud 0
      while [fud < num_firms]
      [
        if [growth_y] of firm fud = true [

          set pegr [PB_ratio] of firm fud              ; crgn = chartist revenue growth n
          if pegr > 3 [set pegr 3]
          if pegr < 0.2 [set pegr .2 ]

          if pegr >= 2 [set decision_score -1]
          if (pegr < 2) and (pegr >= 1)  [set decision_score 0]
          if pegr < 1 [set decision_score 1 ]

          set actions lput decision_score actions

          if decision_score = 0 [ set convinction lput 0 convinction]

          if decision_score = 1
          [

            let con (1 - pegr) / .8    ; (1 - lower bound of pegr)   ;
            set convinction lput con convinction
          ]

          if decision_score = -1
          [
            let con (pegr - 2)
            set convinction lput con convinction
          ]
        ]

        if [growth_y] of firm fud = false [

          set pegr [PB_ratio] of firm fud
          if pegr > 3 [set pegr 3]
          if pegr < 0.2 [set pegr .2 ]

          if pegr >= 2 [set decision_score -1]
          if (pegr < 2) and (pegr >= 1) [set decision_score 0]
          if pegr < 1 [set decision_score 1]

          set actions lput decision_score actions

          if decision_score = 0 [ set convinction lput 0 convinction]

          if decision_score = 1
          [

            let con (1 - pegr) / .8       ; (1 - lower bound of pegr)
            set convinction lput con convinction
          ]
          if decision_score = -1
          [

            let con (pegr - 2)
            set convinction lput con convinction
          ]
        ]
        set fud (fud + 1)
      ]
    ]
  ]
end

to order_book
  set order_bank []
  set order_bank_all []
  set order_bank_all [trades] of investors

  let x 0
  while [ x < num_firms ]
  [ let temp sum map [ ?1 -> item x ?1 ] order_bank_all
    set order_bank lput temp order_bank
    set x (x + 1)
  ]

end

to clear_market

  set s_price_list_temp s_price_list
  set return_list_t-1 return_list
  set return_list []
  set esembled_average_t-1 esembled_average
  set esembled_average []
  set stddev_rt_1 stddev_rt
  set stddev_rt []
  set s_price_list []
  set newpricelog 0   ;;

  let j 0
  while [ j < num_firms ]

  [ let temp_orders item j order_bank

    let return_temp (1 / ( 100 * market_depth )) * temp_orders   ;  took the 25 out as...

    set newpricelog (log (item j s_price_list_temp) 10) + return_temp      ;; this works now. Issue is size of r...

    if   newpricelog < -300 [set newpricelog -300] ;; major stop gap here

    set newprice 10 ^ newpricelog

    set s_price_list lput newprice s_price_list                      ;;;;; here is the overal price list

    ask firms [
      if firm_ID = j [
        set moving_s_price (memory_weight * moving_s_price)   + (1 - memory_weight) * newprice
      ]
    ]

    set return return_temp + log ((newprice ) / newprice) 10

    set return_list lput return return_list                                 ; need to update asset later  this could be ugly figure

    let esrt memory_weight * item j esembled_average_t-1 + ( 1 - memory_weight) * item j return_list  ; took out t-1

    set esembled_average lput esrt esembled_average

    let varrt (memory_weight * (item j stddev_rt_1 ^ 2)) + (( 1 - memory_weight ) * ( item j return_list - item j esembled_average ) ^ 2) ; took out t-1

    let stddevrtj (varrt) ^ .5

    set stddev_rt lput stddevrtj stddev_rt

    let facto return / stddevrtj

    ask firm j [                              ;; asset j ensures that it gets the right history
      set s_price item j s_price_list
      set rti item j return_list

      let non_log_rti (10 ^ rti) - 1
      set a_rt lput non_log_rti a_rt

      let stdevrti item j stddev_rt
      set stdevrt lput stdevrti stdevrt
    ]
    set j (j + 1)
  ]

  let index_n-1 index
  set index (sum s_price_list / num_firms)
  set grow_i ( index / index_n-1 ) - 1
end

to investor_update

  ask investors [
    let portfolio_temp portfolio
    set portfolio []
    let p 0
    while [ p < num_firms ]

    [ let newholding (item p portfolio_temp + item p trades)     ; add here  buys is positive while sale is a negative value for trade
      if newholding < 0 [set neg neg + 1]
      set portfolio lput newholding portfolio
      let proceeds (item p trades * item p s_price_list)
      set cash cash - proceeds
      set p (p + 1)
    ]
  ]
end

to portfolio_valuation

  let pv_n_1 sum [portfolio_value] of investors

  ask investors [
    let portfolio_value_t-1 portfolio_value
    set portfolio_value_i []
    let t 0
    while [ t < num_firms
    ]
    [let value (item t portfolio * item t s_price_list)
      set portfolio_value_i lput value portfolio_value_i
      set t (t + 1)
    ]
    set portfolio_value sum portfolio_value_i
    set portfolio_value_history lput portfolio_value portfolio_value_history
    set portfolio_return (portfolio_value / portfolio_value_t-1 ) - 1
    set port_return_history lput portfolio_return port_return_history
  ]

  let pv_n sum [portfolio_value] of investors
  set grow_i (pv_n / pv_n_1) - 1
end

to investors_pro

  ask investors [
    set ownership_pro []

    let x 0
    while [ x < num_firms ]

    [ let temp item x portfolio / item x share_volume
      set ownership_pro lput temp  ownership_pro
      set x (x + 1)
    ]
  ]
end

to adjust_expectations     ;;; here i have all called all firms to do this. Therefore, called ask individuals agents to call the function

  ask firms [
    ifelse  met_p_e_y = true  [
      ifelse pex_gap < .1 [           ;;;;  guess here at 10%
        set hit1 hit1 + 1
        ifelse growth_y = true [

          let old r_effort         ;;;;      keep old
          set r_effort  old ^ (1 + pex_gap)
          if r_effort >= .98 [set r_effort .95]     ;; can not drop below .500
          if r_effort <= .5 [set r_effort .51]
          set m_effort 1 - r_effort
          set reinv exp(1 - (1 / (r_effort ^ 2)))
        ]
        [set olda m_effort
          set m_effort  olda ^ (1 + pex_gap)   ;;;;;;;;;;;; Bug because should be going to 0
          if m_effort >= .98 [set m_effort .96]    ;; can not drop below .500
          if m_effort <= .5 [set m_effort .51]
          set r_effort 1 - m_effort
          set reinv interest_rate + (.15 * (m_effort ^ 1.5))   ;;;; was wrong here as had reinv for sales growth
        ]
      ]
      [
        ;;;change expectaions
        let old expectation
        set expectation old * ((1 + (pex_gap * .05)))
        set exp_changes_+ exp_changes_+ + 1      ;;  lets not carried away here
        set hit2 hit2 + 1
      ]
    ]
    ;;;;;;;;;; missed expectations

    [  ifelse miss_count >  1 / abs(ln(memory_weight))           ;; those if false. Now check miss counter

      [ let old expectation
        set expectation old * ((1 + (pex_gap * .25)))
        set miss_count 0
        set hit3 hit3 + 1
        set exp_changes_- exp_changes_- + 1
        allocate_effort
      ]
      [ ifelse growth_y = true [
        set olda r_effort
        set r_effort  olda ^ (1 + pex_gap)
        if r_effort >= .98 [set r_effort .96]
        if r_effort <= .5 [set r_effort .51]
        set m_effort 1 - r_effort
        set reinv exp(1 - (1 / (r_effort ^ 2)))
        set hit4 hit4 + 1
        ]
        [set olda m_effort
          set m_effort  olda ^ (1 + pex_gap)
          if m_effort >= .98 [set m_effort .96]
          if m_effort <= .5 [set m_effort .51]
          set r_effort 1 - m_effort
          set reinv exp(1 - (1 / (m_effort ^ 2)))
          set hit5 hit5 + 1
        ]
      ]
    ]
  ]
end

to influence
  ask firms [

    ;;;;;;;;;;;;;;;;;;;;;;;;;  Material increase in the share price  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


    set  non_log_rti_a  (10 ^ rti) - 1
    if (non_log_rti_a >= .01)   [
      ;;;;   1 means riding the wave    NEEDS TO CHANGE TO MAINTAINING
      let c random 2
      ifelse c = 1
      [
        let pre expectation                          ;;;;; this set is about increasing affter  the expectation based on the market conceern
        let move  non_log_rti_a
        if move > 1 [set move 1]
        set expectation (1 / (1 + (1 / pre - 1) * exp(- price_concern * move)))
        set exp_changes_+ exp_changes_+ + 1
        if expectation > .98 [set expectation .95]
        allocate_effort
        set hit1 hit1 + 1

      ]
      [ let pre expectation                          ;;;;; this set is about reducing the expectation based on the market conceern
        let move  non_log_rti_a
        if move > 1 [set move 1]
        ifelse miss_count >  1 / abs(ln(memory_weight))
        [
          set expectation (1 / (1 + (1 / pre - 1) * exp(price_concern * move)))
          if expectation < .01 [set expectation .01]
          set exp_changes_- exp_changes_- + 1
          allocate_effort
          set hit2 hit2 + 1
        ]

        [ if non_log_rti_a >= .01
          [
            ifelse growth_y = true [
              let old r_effort         ;;;;      keep old
              set r_effort  old ^ (1 + pex_gap)
              if r_effort >= .98 [set r_effort .96]     ;; can not drop below .500
              if r_effort <= .5 [set r_effort .51]
              set m_effort 1 - r_effort
              set reinv exp(1 - (1 / (r_effort ^ 2)))
              set hit3 hit3 + 1
            ]
            [set olda m_effort
              set m_effort  olda ^ (1 + pex_gap)   ;;;;;;;;;;;; Bug because should be going to 0
              if m_effort >= .98 [set m_effort .96]
              if m_effort <= .5 [set m_effort .51]
              set r_effort 1 - m_effort
              set reinv interest_rate + (.15 * (m_effort ^ 1.5))
              set hit7 hit7 + 1  ;;;; was wrong here as had reinv for sales growth
            ]
          ]
        ]
      ]
    ]

    ;;;;;;;;;;;;;;;;;;;;;;;;;  Material decline in the share price  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    if ( non_log_rti_a  <= -.01)      ;;; NEED TO CHECK WHETHER CONTINUALY MISSED. IF NOT WILL INCREASE EFFORT.  BUT THIS IS NOT FOR FLAT

    [
      ifelse pex_gap > 0
      [
        let pre expectation                ;;;;;;     want this as the original MUST make old a variable
        let move  non_log_rti_a
        if move < -1 [set move -1]
        set expectation (1 / (1 + (1 / pre - 1) * exp(price_concern * move)))   ;; because move is negative will increase
        set exp_changes_+ exp_changes_+ + 1
        allocate_effort
        set hit4 hit4 + 1
      ]
      [do_ae_1
        set hit5 hit5 + 1]
    ]
    ;;;;;;;;;;;;;;;;;;;;;;;;;  Non-material decline in the share price  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    if (non_log_rti_a > -.01) and (non_log_rti_a < .01)
    [do_ae
      set hit6 hit6 + 1]

  ]
end

to do_ae
  ifelse  met_p_e_y = true  [
    ifelse pex_gap < .1 [           ;;;;  guess here at 10%

      ifelse growth_y = true [

        let old r_effort         ;;;;      keep old
        set r_effort  old ^ (1 + pex_gap)
        if r_effort >= .98 [set r_effort .96]     ;; can not drop below .500
        if r_effort <= .5 [set r_effort .51]
        set m_effort 1 - r_effort
        set reinv exp(1 - (1 / (r_effort ^ 2)))
      ]
      [set olda m_effort
        set m_effort  olda ^ (1 + pex_gap)   ;;;;;;;;;;;; Bug because should be going to 0
        if m_effort >= .98 [set m_effort .96]
        if m_effort <= .5 [set m_effort .51]
        set r_effort 1 - m_effort
        set reinv interest_rate + (.15 * (m_effort ^ 1.5))   ;;;; was wrong here as had reinv for sales growth
      ]
    ]
    [
      ;;;change expectaions
      let old expectation
      set expectation old * ((1 + (pex_gap * .1)))
      set exp_changes_+ exp_changes_+ + 1   ;;;; needs caps
    ]
  ]

  [  ifelse miss_count >  1 / abs(ln(memory_weight))           ;; those if false. Now check miss counter

    [ let old expectation
      set expectation old * ((1 + (pex_gap * .25)))
      set exp_changes_- exp_changes_- + 1
      set miss_count 0

      allocate_effort
    ]
    [ ifelse growth_y = true [
      set olda r_effort
      set r_effort  olda ^ (1 + pex_gap)
      if r_effort >= .98 [set r_effort .96]
      if r_effort <= .5 [set r_effort .51]
      set m_effort 1 - r_effort
      set reinv exp(1 - (1 / (r_effort ^ 2)))
      ]
      [set olda m_effort
        set m_effort  olda ^ (1 + pex_gap)
        if m_effort >= .98 [set m_effort .96]
        if m_effort <= .5 [set m_effort .51]
        set r_effort 1 - m_effort
        set reinv exp(1 - (1 / (m_effort ^ 2)))
      ]
    ]
  ]
end

to do_ae_1           ;;;;; just adjusting effort so I think I call this whenever......

  ifelse growth_y = true [

    let old r_effort         ;;;;      keep old
    set r_effort  old ^ (1 + pex_gap)
    if r_effort >= .98 [set r_effort .96]     ;; can not drop below .500
    if r_effort <= .5 [set r_effort .51]
    set m_effort 1 - r_effort
    set reinv exp(1 - (1 / (r_effort ^ 2)))
  ]
  [set olda m_effort
    set m_effort  olda ^ (1 + pex_gap)   ;;;;;;;;;;;; Bug because should be going to 0
    if m_effort >= .98 [set m_effort .96]
    if m_effort <= .5 [set m_effort .51]
    set r_effort 1 - m_effort
    set reinv interest_rate + (.15 * (m_effort ^ 1.5))   ;;;; was wrong here as had reinv for sales growth
  ]

end

to jack_investors

  set hitall  sum [hit1] of firms + sum [hit2] of firms + sum [hit3] of firms + sum [hit4] of firms + sum [hit5] of firms + sum [hit6] of firms + sum [hit7] of firms

  set dividends_all []

  let d 0
  while [d < num_firms ][
    let div [dividend] of firm d
    set dividends_all lput div dividends_all
    set d (d + 1)
  ]


  ask investors  [
    set div_har []
    let h 0
    while [h < num_firms ] [
      let pay item h ownership_pro * item h dividends_all
      set div_har lput pay div_har
      set h (h + 1)
    ]
    set  dividends_received sum div_har
  ]

  ask investors [
    ifelse cash > 0

    [set cash cash + dividends_received ]
    [set cash 0 + dividends_received]
  ]

  let earnings_n-1 earnings
  let e_1 earnings

  set earnings sum [profit] of firms    ;; goes fist

  set grow_e (earnings / earnings_n-1) - 1

  set met_exp count firms with [met_p_e_y = true]

  set pop_change_exp sum [exp_changes_+] of firms

  set eg_of_mkt (earnings / e_1) - 1

end
@#$#@#$#@
GRAPHICS-WINDOW
93
222
245
375
-1
-1
13.1
1
10
1
1
1
0
1
1
1
-5
5
-5
5
0
0
1
ticks
30.0

TEXTBOX
21
74
171
92
Market Details
11
0.0
1

BUTTON
12
11
85
44
NIL
set_up
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
85
11
153
44
NIL
step
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
153
11
218
44
NIL
go
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SLIDER
10
90
182
123
num_firms
num_firms
5
500
80.0
5
1
NIL
HORIZONTAL

SLIDER
191
150
363
183
price_concern
price_concern
0
2
0.0
.5
1
NIL
HORIZONTAL

TEXTBOX
193
73
343
91
Firms/Management
11
0.0
1

TEXTBOX
379
76
529
94
Investors
11
0.0
1

SLIDER
191
184
363
217
ave_ability
ave_ability
0
1
0.5
.1
1
NIL
HORIZONTAL

INPUTBOX
220
10
290
70
stop_after
2000.0
1
0
Number

INPUTBOX
191
89
364
149
capital
1.0
1
0
Number

SLIDER
12
125
184
158
interest_rate
interest_rate
0.05
.1
0.05
.01
1
NIL
HORIZONTAL

SLIDER
190
220
362
253
g
g
5
10
10.0
1
1
NIL
HORIZONTAL

SLIDER
362
248
534
281
memory_weight
memory_weight
0
.99
0.9
.01
1
NIL
HORIZONTAL

SLIDER
12
160
184
193
market_depth
market_depth
0.1
1
0.15
.05
1
NIL
HORIZONTAL

TEXTBOX
817
413
967
497
defaults\ninterest_rate 0.05\ng 10\nave_ability .5\nt_ratio .15\nmarket_depth .2
11
0.0
1

SLIDER
13
197
185
230
growth_pro
growth_pro
0
1
0.5
.1
1
NIL
HORIZONTAL

SLIDER
362
282
534
315
transaction_ratio
transaction_ratio
0.01
.2
0.15
.01
1
NIL
HORIZONTAL

MONITOR
16
398
79
443
actions
sum [actions] of investor num_firms
1
1
11

PLOT
252
326
525
510
Index
NIL
NIL
0.0
10.0
0.0
0.1
true
false
"" ""
PENS
"default" 1.0 0 -16777216 true "" "plot index "

PLOT
572
14
792
161
Meeting Exp%
NIL
NIL
0.0
10.0
0.0
1.0
true
true
"" ""
PENS
"yes" 1.0 0 -16777216 true "" "plot (count firms with [met_p_e_y = true]) / count firms"
"no" 1.0 0 -7500403 true "" "plot (count firms with [met_p_e_y = false]) / count firms "

MONITOR
23
457
172
502
cash I 1
sum [cash] of investors
2
1
11

MONITOR
18
296
99
341
+ exp
sum [exp_changes_+] of firms
17
1
11

PLOT
570
162
792
317
changing expectations
NIL
NIL
0.0
10.0
0.0
1.0
true
true
"" ""
PENS
"up" 1.0 0 -16777216 true "" "plot  sum [exp_changes_+] of firms"
"down" 1.0 0 -7500403 true "" "plot  sum [exp_changes_-] of firms"

SWITCH
378
89
526
122
chartist_earnings
chartist_earnings
1
1
-1000

SWITCH
378
121
526
154
chartist_price
chartist_price
1
1
-1000

SWITCH
378
187
532
220
fund_peg
fund_peg
0
1
-1000

SWITCH
378
218
503
251
fund_value
fund_value
1
1
-1000

SWITCH
378
154
526
187
fund_pe
fund_pe
1
1
-1000

PLOT
525
326
788
510
Activity of firms
NIL
NIL
0.0
10.0
0.0
10.0
true
true
"" ""
PENS
"h1" 1.0 0 -16777216 true "" "plot sum [hit1] of firms "
"h2" 1.0 0 -7500403 true "" "plot sum [hit2] of firms "
"h3" 1.0 0 -13345367 true "" "plot sum [hit3] of firms "
"h4" 1.0 0 -955883 true "" "plot sum [hit4] of firms "
"h5" 1.0 0 -2674135 true "" "plot sum [hit5] of firms "
"h6" 1.0 0 -1184463 true "" "plot sum [hit6] of firms "
"h7" 1.0 0 -2064490 true "" "plot sum [hit7] of firms "

@#$#@#$#@
## WHAT IS IT?

(a general understanding of what the model is trying to show or explain)

## HOW IT WORKS

(what rules the agents use to create the overall behavior of the model)

## HOW TO USE IT

(how to use the model, including a description of each of the items in the Interface tab)

## THINGS TO NOTICE

(suggested things for the user to notice while running the model)

## THINGS TO TRY

(suggested things for the user to try to do (move sliders, switches, etc.) with the model)

## EXTENDING THE MODEL

(suggested things to add or change in the Code tab to make the model more complicated, detailed, accurate, etc.)

## NETLOGO FEATURES

(interesting or unusual features of NetLogo that the model uses, particularly in the Code tab; or where workarounds were needed for missing features)

## RELATED MODELS

(models in the NetLogo Models Library and elsewhere which are of related interest)

## CREDITS AND REFERENCES

(a reference to the model's URL on the web if it has one, as well as any other necessary credits, citations, and links)
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

sheep
false
15
Circle -1 true true 203 65 88
Circle -1 true true 70 65 162
Circle -1 true true 150 105 120
Polygon -7500403 true false 218 120 240 165 255 165 278 120
Circle -7500403 true false 214 72 67
Rectangle -1 true true 164 223 179 298
Polygon -1 true true 45 285 30 285 30 240 15 195 45 210
Circle -1 true true 3 83 150
Rectangle -1 true true 65 221 80 296
Polygon -1 true true 195 285 210 285 210 240 240 210 195 210
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

wolf
false
0
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -7500403 true true 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -7500403 true true -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270
@#$#@#$#@
NetLogo 6.0.4
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
<experiments>
  <experiment name="experiment" repetitions="5" runMetricsEveryStep="true">
    <setup>set_up</setup>
    <go>go</go>
    <timeLimit steps="1000"/>
    <metric>mean [PE_ratio] of firms</metric>
    <metric>mean [PB_ratio] of firms</metric>
    <metric>index</metric>
    <metric>met_exp</metric>
    <metric>num_firms - met_exp</metric>
    <metric>sum [exp_changes_+] of firms</metric>
    <metric>sum [exp_changes_-] of firms</metric>
    <enumeratedValueSet variable="ave_ability">
      <value value="0.4"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="price_concern">
      <value value="0"/>
      <value value="1"/>
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="capital">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="g">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="memory_weight">
      <value value="0.85"/>
      <value value="0.9"/>
      <value value="0.95"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="kind_selector">
      <value value="&quot;ce&quot;"/>
      <value value="&quot;cp&quot;"/>
      <value value="&quot;fe&quot;"/>
      <value value="&quot;fp&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="num_firms">
      <value value="300"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="interest_rate">
      <value value="0.05"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="growth_pro">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="transaction_ratio">
      <value value="0.1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="stop_after">
      <value value="1000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="market_depth">
      <value value="0.15"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="number_of_investors">
      <value value="1"/>
    </enumeratedValueSet>
  </experiment>
</experiments>
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180
@#$#@#$#@
0
@#$#@#$#@
