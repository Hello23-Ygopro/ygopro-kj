--Cumulofungus
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_FLYING_FUNGUS)
	--creature
	aux.EnableCreatureAttribute(c)
	--to mana zone
	aux.AddTriggerEffectWinBattle(c,0,true,scard.tg1,scard.op1,nil,scard.con1)
end
--to mana zone
scard.con1=aux.BattleWinCondition()
scard.tg1=aux.DecktopSendtoMZoneTarget(PLAYER_SELF)
scard.op1=aux.DecktopSendtoMZoneOperation(PLAYER_SELF,1)
