--Wild Sky Sword
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_STORM_PATROL,RACE_BEAST_KIN)
	--creature
	aux.EnableCreatureAttribute(c)
	--powerful attack
	aux.EnablePowerfulAttack(c,4000)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--to shield zone
	aux.AddSingleTriggerEffectWinBattle(c,0,true,aux.DecktopSendtoSZoneTarget(PLAYER_SELF),aux.DecktopSendtoSZoneOperation(PLAYER_SELF,1))
end
