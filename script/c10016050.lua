--Twisted Vicejaw
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_VOID_SPAWN,RACE_STOMPER)
	--creature
	aux.EnableCreatureAttribute(c)
	--clash (get ability)
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,true,aux.ClashTarget(PLAYER_SELF),scard.op1)
end
--clash (get ability)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.Clash(tp) then return end
	local c=e:GetHandler()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CREATURE)
	local g=Duel.SelectMatchingCard(tp,Card.IsFaceup,tp,LOCATION_BZONE,0,1,1,c)
	if g:GetCount()==0 then return end
	Duel.HintSelection(g)
	--powerful attack
	aux.AddTempEffectPowerfulAttack(c,g:GetFirst(),1,5000)
end
