--The Mystic of Nature
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_MYSTIC)
	--creature
	aux.EnableCreatureAttribute(c)
	--to mana zone
	aux.AddTriggerEffectPlayerCastSpell(c,0,PLAYER_SELF,scard.tmfilter,nil,nil,scard.op1)
end
--to mana zone
scard.tmfilter=aux.FilterBoolFunction(Card.IsCivilization,CIVILIZATION_NATURE)
scard.op1=aux.SendtoMZoneOperation(PLAYER_SELF,aux.KJDPileFilter(Card.IsCreature),LOCATION_DPILE,0,1)
