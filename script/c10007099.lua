--Kronax the Brutal
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ROT_WORM,RACE_DRAKON)
	--creature
	aux.EnableCreatureAttribute(c)
	--get ability
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,aux.HintTarget,scard.op1)
	--get ability
	aux.AddSingleTriggerEffect(c,1,EVENT_COME_INTO_PLAY,nil,aux.HintTarget,scard.op2)
end
--get ability
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CREATURE)
	local g=Duel.SelectMatchingCard(tp,Card.IsFaceup,tp,LOCATION_BZONE,0,1,1,c)
	if g:GetCount()==0 then return end
	Duel.HintSelection(g)
	--slayer
	aux.AddTempEffectSlayer(c,g:GetFirst(),2)
end
--get ability
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CREATURE)
	local g=Duel.SelectMatchingCard(tp,Card.IsFaceup,tp,LOCATION_BZONE,0,1,1,c)
	if g:GetCount()==0 then return end
	Duel.HintSelection(g)
	--attack untapped
	aux.AddTempEffectCustom(c,g:GetFirst(),3,EFFECT_ATTACK_UNTAPPED)
end
