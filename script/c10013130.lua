--Colonel Corn
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_WILD_VEGGIE)
	--creature
	aux.EnableCreatureAttribute(c)
	--get ability
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,scard.op1)
end
--get ability
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CREATURE)
	local g=Duel.SelectMatchingCard(tp,Card.IsFaceup,tp,LOCATION_BZONE,0,1,1,c)
	if g:GetCount()==0 then return end
	Duel.HintSelection(g)
	--power up
	aux.AddTempEffectUpdatePower(c,g:GetFirst(),1,4000)
end
