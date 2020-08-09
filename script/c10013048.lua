--Scavenging Cenophor
--Not fully implemented: "Sift for Treasure" does not replace the number of cards you draw (or would have drawn)
--Note: Changed effect to match YGOPro's game system
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_EARTH_EATER)
	--creature
	aux.EnableCreatureAttribute(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--draw, discard
	local e1=aux.AddTriggerEffect(c,0,EVENT_DRAW,true,aux.DrawTarget(PLAYER_SELF),scard.op1,nil,scard.con1)
	e1:SetCountLimit(1,sid)
	if not scard.global_check then
		scard.global_check=true
		--check cards drawn
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_DRAW)
		ge1:SetOperation(scard.regop1)
		Duel.RegisterEffect(ge1,0)
	end
end
--check cards drawn
function scard.regop1(e,tp,eg,ep,ev,re,r,rp)
	for i=1,ev do
		Duel.RegisterFlagEffect(ep,sid,RESET_PHASE+PHASE_END,0,1)
	end
end
--draw, discard
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return ep==tp and Duel.GetFlagEffect(tp,sid)==0 and ev<3
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.Draw(tp,3-ev,REASON_EFFECT)==0 then return end -- -ev so you won't draw more cards than you're supposed to
	Duel.ShuffleHand(tp)
	Duel.DiscardHand(tp,aux.TRUE,2,2,REASON_EFFECT)
end
--[[
	Rulings
	Q: Say I summon this creature after having drawn a card for my turn. If I draw a card later that turn, can I use
	"Sift for Treasure"?
		A: No. "Sift for Treasure" looks at the entire turn to see if it's the first time you would draw a card during
		that turn, even if this creature wasn't in the battle zone at the time.
	https://kaijudo.fandom.com/wiki/Scavenging_Cenophor/Rulings
]]
