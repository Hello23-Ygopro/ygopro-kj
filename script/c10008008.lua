--Bone Blades (Alias)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--shield blast
	aux.EnableShieldBlast(c)
	--banish
	aux.AddSpellCastEffect(c,0,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--banish
function scard.banfilter(c)
	return c:IsFaceup() and c:IsManaCostBelow(4) and c:KJIsBanishable()
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,scard.banfilter,0,LOCATION_BZONE,1,1,HINTMSG_BANISH)
scard.op1=aux.TargetCardsOperation(Duel.KJBanish,REASON_EFFECT)
--[[
	Rulings
		Q: What does it mean when a creature can't be banished?
		A: If any spell, creature's ability, or game rule would cause the creature to be banished, it simply stays in the
		battle zone. For example, if such a creature loses a battle, it stays in the battle zone. Any ability that
		triggered when that creature loses a battle would still trigger, but abilities that trigger when a creature is
		banished would not. If a spell or a creature's ability gives you the option to banish one of your own creatures
		for an effect (like Ripper Reaper does, for example), you can't choose to banish a creature that can't be
		banished. If a creature's power is 0 or less, it is banished as normal.
		https://kaijudo.fandom.com/wiki/Swift_Regeneration/Rulings
]]
