--Lepidos the Ancient
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_MEGABUG)
	--creature
	aux.EnableCreatureAttribute(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--to mana zone
	aux.AddTriggerEffectWinBattle(c,0,nil,nil,scard.op1,nil,scard.con1)
end
--to mana zone
scard.con1=aux.BattleWinCondition()
scard.op1=aux.SendtoMZoneOperation(PLAYER_SELF,aux.ShieldZoneFilter(),0,LOCATION_SZONE,1)
