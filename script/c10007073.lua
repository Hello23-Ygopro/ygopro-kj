--Elevan the Seeker
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ENFORCER,RACE_CYBER_LORD)
	--creature
	aux.EnableCreatureAttribute(c)
	--tap
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
	--get ability
	aux.AddSingleTriggerEffect(c,1,EVENT_COME_INTO_PLAY,nil,aux.HintTarget,scard.op2)
end
--tap
function scard.posfilter(c)
	return c:IsFaceup() and c:IsAbleToTap()
end
scard.tg1=aux.TargetCardFunction2(PLAYER_SELF,scard.posfilter,0,LOCATION_BZONE,1,1,HINTMSG_TAP)
scard.op1=aux.TargetCardsOperation(Duel.Tap,REASON_EFFECT)
--get ability
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CREATURE)
	local g=Duel.SelectMatchingCard(tp,Card.IsFaceup,tp,LOCATION_BZONE,0,1,1,c)
	if g:GetCount()==0 then return end
	Duel.HintSelection(g)
	--cannot be blocked
	aux.AddTempEffectCannotBeBlocked(c,g:GetFirst(),2)
end
--[[
	Rulings
	Q: When Oktuska enters the battlefield, in what order do I use its 2 abilities?
		A: Because the "Ingenuity" and "Mana Tendrils" abilities both trigger at the same time, you can use those
		abilities in either order.
	https://kaijudo.fandom.com/wiki/Oktuska_the_Infused/Rulings
]]
