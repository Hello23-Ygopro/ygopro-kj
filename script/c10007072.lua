--Crusader Engine
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_BATTLE_SPHERE,RACE_UNDERTOW_ENGINE)
	--creature
	aux.EnableCreatureAttribute(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--untap
	aux.EnableTurnEndSelfUntap(c)
	--banish replace (return)
	aux.AddSingleReplaceEffectBanish(c,0,scard.tg1,scard.op1)
end
--banish replace (return)
scard.tg1=aux.SingleReplaceBanishTarget(Card.IsAbleToHand)
scard.op1=aux.SingleReplaceBanishOperation(Duel.SendtoHand,PLAYER_OWNER,REASON_EFFECT+REASON_REPLACE)
