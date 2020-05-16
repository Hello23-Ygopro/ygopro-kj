--Shapeshifter Scaradorable
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CHIMERA)
	aux.AddNameCategory(c,NAMECAT_SCARADORABLE)
	--creature
	aux.EnableCreatureAttribute(c)
	--evolution
	aux.AddEvolutionProcedure(c)
	--return
	aux.AddSingleTriggerEffect(c,0,EVENT_BANISHED,nil,nil,scard.op1)
	--evolution any race
	aux.EnableEffectCustom(c,EFFECT_EVOLUTION_ANY_RACE)
	--evolution any name
	aux.EnableEffectCustom(c,EFFECT_EVOLUTION_ANY_CODE)
	--evolution any civilization
	aux.EnableEffectCustom(c,EFFECT_EVOLUTION_ANY_CIVILIZATION)
end
--return
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsDPile() and c:IsAbleToHand() and Duel.SendtoHand(c,PLAYER_OWNER,REASON_EFFECT)>0 then
		Duel.ConfirmCards(1-tp,c)
	end
end
