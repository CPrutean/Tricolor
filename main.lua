--- STEAMODDED HEADER
--- MOD_NAME: Tricolor
--- MOD_ID: Tricolor
--- MOD_AUTHOR: [Slimeinator]
--- MOD_DESCRIPTION: Balatro mod for Max and Aubreys third year anniversary


SMODS.Atlas {
    key = 'Jokers',
    path = 'Jokers.png',
    px = 71,
    py = 95
}


SMODS.Joker{
    key = 'joker2',
    loc_txt = {
        name = "Tricolor",
        text = {
            "Playing a hand",
            "Containing 3 suits",
            "Gives {X:mult,C:white} X3 {} Mult"
        }
    },
    config = {extra = {x_mult = 3}},
    rarity = 2,
    atlas = 'Jokers',
    pos = {x=0, y=0},
    cost = 6,
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.Xmult}}
    end,
    calculate = function(self,card,context)
        if context.joker_main then
            if self.debuff then return nil end
            local suits = {
                ['Hearts'] = 0,
                ['Diamonds'] = 0,
                ['Spades'] = 0,
                ['Clubs'] = 0
            }
            for i=1, #context.scoring_hand do
                if context.scoring_hand[i].ability.name ~= "Wild card" then
                    if context.scoring_hand[i]:is_suit('Hearts', true) and suits["Hearts"] == 0 then suits["Hearts"] = suits["Hearts"]+1
                    elseif context.scoring_hand[i]:is_suit('Diamonds', true) and suits["Diamonds"] == 0 then suits["Diamonds"] = suits["Diamonds"]+1
                    elseif context.scoring_hand[i]:is_suit('Spades', true) and suits["Spades"] == 0 then suits["Spades"] = suits["Spades"]+1
                    elseif context.scoring_hand[i]:is_suit('Clubs',true) and suits["Clubs"] == 0 then suits["Clubs"] = suits["Clubs"]+1 end
                end
            end

            for i=1, #context.scoring_hand do
                if context.scoring_hand[i].ability.name == "Wild card" then
                    if context.scoring_hand[i]:is_suit('Hearts', true) and suits["Hearts"] == 0 then suits["Hearts"] = suits["Hearts"]+1
                    elseif context.scoring_hand[i]:is_suit('Diamonds', true) and suits["Diamonds"] == 0 then suits["Diamonds"] = suits["Diamonds"]+1
                    elseif context.scoring_hand[i]:is_suit('Spades', true) and suits["Spades"] == 0 then suits["Spades"] = suits["Spades"]+1
                    elseif context.scoring_hand[i]:is_suit('Clubs',true) and suits["Clubs"] == 0 then suits["Clubs"] = suits["Clubs"]+1 end
                end
            end
            local num = 0;
            if suits["Hearts"] > 0 then num = num+1 end
            if suits["Diamonds"] > 0 then num = num+1 end
            if suits["Spades"] > 0 then num = num+1 end
            if suits["Clubs"] > 0 then num = num+1 end
            if num > 2 then
                return {
                    --message = localize{type='variable',key='a_xmult',vars={card.ability.extra.x_mult}},
                    x_mult = card.ability.extra.x_mult
                }
            end
        end
    end,
    discovered = true,
    unlocked = true,
    blueprint_compat = true
}