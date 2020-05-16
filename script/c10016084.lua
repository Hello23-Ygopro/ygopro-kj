--Shagathar the Voidreacher
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_VOID_SPAWN,RACE_ARMORED_DRAGON)
	aux.AddRaceCategory(c,RACECAT_DRAGON)
	--creature
	aux.EnableCreatureAttribute(c)
	--fast attack
	aux.EnableEffectCustom(c,EFFECT_FAST_ATTACK)
	--clash (to battle)
	aux.AddSingleTriggerEffect(c,0,EVENT_ATTACK_ANNOUNCE,true,aux.ClashTarget(PLAYER_SELF),scard.op1)
end
--clash (to battle)
function scard.tbfilter(c,e,tp)
	return c:IsEvolution() and c:KJIsRace(RACE_VOID_SPAWN) and c:IsAbleToBZone(e,0,tp,false,false)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.Clash(tp) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOBZONE)
	local g=Duel.SelectMatchingCard(tp,scard.tbfilter,tp,LOCATION_HAND,0,0,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SendtoBZone(g,0,tp,tp,false,false,POS_FACEUP_UNTAPPED)
	end
end
