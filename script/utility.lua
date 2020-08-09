Auxiliary={}
aux=Auxiliary

--
function Auxiliary.Stringid(code,id)
	return code*16+id
end
--
function Auxiliary.Next(g)
	local first=true
	return	function()
				if first then first=false return g:GetFirst()
				else return g:GetNext() end
			end
end
--
function Auxiliary.NULL()
end
--
function Auxiliary.TRUE()
	return true
end
--
function Auxiliary.FALSE()
	return false
end
--
function Auxiliary.AND(...)
	local function_list={...}
	return	function(...)
				local res=false
				for i,f in ipairs(function_list) do
					res=f(...)
					if not res then return res end
				end
				return res
			end
end
--
function Auxiliary.OR(...)
	local function_list={...}
	return	function(...)
				local res=false
				for i,f in ipairs(function_list) do
					res=f(...)
					if res then return res end
				end
				return res
			end
end
--
function Auxiliary.NOT(f)
	return	function(...)
				return not f(...)
			end
end
--
function Auxiliary.BeginPuzzle(effect)
	local e1=Effect.GlobalEffect()
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_TURN_END)
	e1:SetCountLimit(1)
	e1:SetOperation(Auxiliary.PuzzleOp)
	Duel.RegisterEffect(e1,0)
	local e2=Effect.GlobalEffect()
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCode(EFFECT_SKIP_DP)
	e2:SetTargetRange(1,0)
	Duel.RegisterEffect(e2,0)
	local e3=Effect.GlobalEffect()
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetCode(EFFECT_SKIP_SP)
	e3:SetTargetRange(1,0)
	Duel.RegisterEffect(e3,0)
end
function Auxiliary.PuzzleOp(e,tp)
	Duel.SetLP(0,0)
end
--
function Auxiliary.TargetEqualFunction(f,value,...)
	local ext_params={...}
	return	function(effect,target)
				return f(target,table.unpack(ext_params))==value
			end
end
--
function Auxiliary.TargetBoolFunction(f,...)
	local ext_params={...}
	return	function(effect,target)
				return f(target,table.unpack(ext_params))
			end
end
--
function Auxiliary.FilterEqualFunction(f,value,...)
	local ext_params={...}
	return	function(target)
				return f(target,table.unpack(ext_params))==value
			end
end
--
function Auxiliary.FilterBoolFunction(f,...)
	local ext_params={...}
	return	function(target)
				return f(target,table.unpack(ext_params))
			end
end
--get a card script's name and id
function Auxiliary.GetID()
	local str=string.match(debug.getinfo(2,'S')['source'],"c%d+%.lua")
	str=string.sub(str,1,string.len(str)-4)
	local scard=_G[str]
	local sid=tonumber(string.sub(str,2))
	return scard,sid
end
--add a setcode to a card
--required to register a card's race and name category
function Auxiliary.AddSetcode(c,setname)
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_ADD_SETCODE)
	e1:SetValue(setname)
	c:RegisterEffect(e1)
	local m=_G["c"..c:GetOriginalCode()]
	if not m.overlay_setcode_check then
		m.overlay_setcode_check=true
		--fix for evolution source not getting a setcode
		local e2=Effect.GlobalEffect()
		e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
		e2:SetType(EFFECT_TYPE_FIELD)
		e2:SetCode(EFFECT_ADD_SETCODE)
		e2:SetTargetRange(LOCATION_ESOURCE,LOCATION_ESOURCE)
		e2:SetLabel(c:GetCode())
		e2:SetTarget(function(e,c)
			return c:GetCode()==e:GetLabel()
		end)
		e2:SetValue(setname)
		Duel.RegisterEffect(e2,0)
	end
end
--register a card's race(s)
--required for Card.KJIsRace
function Auxiliary.AddRace(c,...)
	if c:IsStatus(STATUS_COPYING_EFFECT) then return end
	if c.race==nil then
		local mt=getmetatable(c)
		mt.race={}
		for _,racename in ipairs{...} do
			table.insert(mt.race,racename)
		end
	else
		for _,racename in ipairs{...} do
			table.insert(c.race,racename)
		end
	end
end
--register a card's race category(s)
--required for Card.IsRaceCategory
function Auxiliary.AddRaceCategory(c,...)
	if c:IsStatus(STATUS_COPYING_EFFECT) then return end
	if c.race_category==nil then
		local mt=getmetatable(c)
		mt.race_category={}
		for _,racecat in ipairs{...} do
			table.insert(mt.race_category,racecat)
		end
	else
		for _,racecat in ipairs{...} do
			table.insert(c.race_category,racecat)
		end
	end
end
--register a card's name category(s)
--required for Card.IsNameCategory
function Auxiliary.AddNameCategory(c,...)
	if c:IsStatus(STATUS_COPYING_EFFECT) then return end
	if c.name_category==nil then
		local mt=getmetatable(c)
		mt.name_category={}
		for _,namecat in ipairs{...} do
			table.insert(mt.name_category,namecat)
		end
	else
		for _,namecat in ipairs{...} do
			table.insert(c.name_category,namecat)
		end
	end
end
--add a description to a card that lists the effects it gained
--Note: The description is removed if con_func returns false
function Auxiliary.AddEffectDescription(c,desc_id,con_func)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_ADJUST)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetRange(LOCATION_BZONE)
	if con_func then e1:SetCondition(con_func) end
	e1:SetOperation(Auxiliary.AddEffectDescOperation(desc_id))
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	if con_func then e2:SetCondition(aux.NOT(con_func)) end
	e2:SetOperation(Auxiliary.RemoveEffectDescOperation(desc_id))
	c:RegisterEffect(e2)
end
function Auxiliary.AddEffectDescOperation(desc_id)
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local c=e:GetHandler()
				local desc=aux.Stringid(c:GetOriginalCode(),desc_id)
				local code=desc_id+300 --300 > the number of cards that exists in a card's set
				if c:GetFlagEffect(code)==0 then
					c:RegisterFlagEffect(code,RESET_EVENT+RESETS_STANDARD+RESET_DISABLE,EFFECT_FLAG_CLIENT_HINT,1,0,desc)
				end
			end
end
function Auxiliary.RemoveEffectDescOperation(desc_id)
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local c=e:GetHandler()
				local code=desc_id+300
				if c:GetFlagEffect(code)>0 then
					c:ResetFlagEffect(code)
				end
			end
end
--sort cards on the top or bottom of a player's deck
function Auxiliary.SortDeck(sort_player,target_player,count,seq)
	--sort_player: the player who sorts the cards
	--target_player: the player whose cards to sort
	--count: the number of cards to sort
	--seq: SEQ_DECK_TOP to sort the top cards or SEQ_DECK_BOTTOM to sort the bottom cards
	local deck_count=Duel.GetFieldGroupCount(target_player,LOCATION_DECK,0)
	if deck_count<count then count=deck_count end
	if count>1 then Duel.SortDecktop(sort_player,target_player,count) end
	if seq~=SEQ_DECK_BOTTOM or count<=0 then return end
	local g=Duel.GetDecktopGroup(target_player,1)
	if count>1 then
		for i=1,count do
			Duel.MoveSequence(g:GetFirst(),seq)
		end
	else Duel.MoveSequence(g:GetFirst(),seq) end
end

--creature card
function Auxiliary.EnableCreatureAttribute(c)
	--register card info
	Auxiliary.RegisterCardInfo(c)
	--summon procedure
	Auxiliary.AddSummonProcedure(c)
	--summon for no cost using "shield blast"
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(DESC_SHIELD_BLAST_C)
	e1:SetCategory(CATEGORY_SHIELD_BLAST)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_CUSTOM+EVENT_TRIGGER_SHIELD_BLAST)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL+EFFECT_FLAG_DELAY)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(Auxiliary.ShieldBlastCondition1)
	e1:SetTarget(Auxiliary.ShieldBlastSummonTarget)
	e1:SetOperation(Auxiliary.ShieldBlastSummonOperation)
	c:RegisterEffect(e1)
	--prevent multiple "shield blast" abilities from chaining
	Auxiliary.AddShieldBlastChainLimit(c,e1)
	--cannot be battle target
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_BZONE)
	e2:SetCondition(Auxiliary.CannotBeBattleTargetCondition)
	e2:SetValue(Auxiliary.CannotBeBattleTargetValue)
	c:RegisterEffect(e2)
	--attack shield
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_ATTACK_SHIELD)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
	e3:SetCondition(Auxiliary.AttackShieldCondition)
	e3:SetOperation(Auxiliary.AttackShieldOperation)
	c:RegisterEffect(e3)
end
--register card info
function Auxiliary.RegisterCardInfo(c)
	if not RaceList then RaceList={} end
	if not RaceCatList then RaceCatList={} end
	local m=_G["c"..c:GetCode()]
	--register race
	if m and m.race then
		for _,racename in ipairs(m.race) do
			Auxiliary.AddSetcode(c,racename)
			table.insert(RaceList,racename)
		end
	end
	--register race category
	if m and m.race_category then
		for _,racecat in ipairs(m.race_category) do
			Auxiliary.AddSetcode(c,racecat)
			table.insert(RaceCatList,racecat)
		end
	end
	--register name category
	if m and m.name_category then
		for _,namecat in ipairs(m.name_category) do
			Auxiliary.AddSetcode(c,namecat)
		end
	end
end
--summon procedure
function Auxiliary.AddSummonProcedure(c,location)
	--location: location for a creature that can be summoned from another location
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(DESC_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SUMMON_CREATURE_PROC)
	e1:SetProperty(EFFECT_FLAG_SUMMON_PARAM+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
	if location then
		e1:SetRange(LOCATION_HAND+location)
	else
		e1:SetRange(LOCATION_HAND)
	end
	e1:SetTargetRange(POS_FACEUP_UNTAPPED,0)
	e1:SetCondition(Auxiliary.NonEvolutionSummonCondition(location))
	e1:SetTarget(Auxiliary.NonEvolutionSummonTarget)
	e1:SetOperation(Auxiliary.NonEvolutionSummonOperation)
	e1:SetValue(SUMMON_TYPE_NONEVOLVE)
	c:RegisterEffect(e1)
end
function Auxiliary.NonEvolutionSummonCondition(location)
	return	function(e,c)
				if c==nil then return true end
				local tp=c:GetControler()
				if c:IsEvolution() or not c:KJIsSummonable(tp) then return false end
				if location then
					if not c:IsLocation(location) then return false end
					--check for "You may summon this creature from your discard pile."
					if location==LOCATION_DPILE and c:IsDPile() then return true
					else return false end
					--check for "You may summon this creature from your mana zone."
					if location==LOCATION_MZONE and c:IsMana() then return true
					else return false end
				end
				local g=Duel.GetMatchingGroup(Auxiliary.ManaZoneFilter(),tp,LOCATION_MZONE,0,nil)
				if Duel.GetLocationCount(tp,LOCATION_BZONE)<=0
					or g:FilterCount(Card.IsUntapped,nil)<c:GetPlayCost() then return false end
				return Auxiliary.PayManaCondition(g,c,c:GetCivilizationCount())
			end
end
function Auxiliary.PayManaCondition(g,c,civ_count)
	local b1=g:IsExists(Card.IsCivilization,1,nil,c:GetFirstCivilization())
	local b2=g:IsExists(Card.IsCivilization,1,nil,c:GetSecondCivilization())
	local b3=g:IsExists(Card.IsCivilization,1,nil,c:GetThirdCivilization())
	local b4=g:IsExists(Card.IsCivilization,1,nil,c:GetFourthCivilization())
	local b5=g:IsExists(Card.IsCivilization,1,nil,c:GetFifthCivilization())
	if civ_count==1 then
		return b1
	elseif civ_count==2 then
		return b1 and b2
	elseif civ_count==3 then
		return b1 and b2 and b3
	elseif civ_count==4 then
		return b1 and b2 and b3 and b4
	elseif civ_count==5 then
		return b1 and b2 and b3 and b4 and b5
	end
end
function Auxiliary.NonEvolutionSummonTarget(e,tp,eg,ep,ev,re,r,rp,chk,c)
	--check for "You may summon this creature from your hand for free."
	if c:IsHasEffect(EFFECT_SUMMON_FOR_FREE) and Duel.SelectYesNo(c:GetControler(),YESNOMSG_SUMMONFREE) then
		e:SetLabel(1)
		return true
	end
	return true
end
function Auxiliary.NonEvolutionSummonOperation(e,tp,eg,ep,ev,re,r,rp,c)
	if e:GetLabel()==1 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TAP)
	local g=Duel.SelectMatchingCard(tp,Card.IsAbleToTap,tp,LOCATION_MZONE,0,c:GetPlayCost(),c:GetPlayCost(),nil)
	Duel.PayManaCost(g)
end
--prevent multiple "shield blast" abilities from chaining
function Auxiliary.AddShieldBlastChainLimit(c,effect,prop)
	prop=prop or 0
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_CHAINING)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		e:GetLabelObject():SetLabel(0)
	end)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_CHAIN_SOLVED)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_HAND)
	e2:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		if rp==1-tp or not re:IsHasCategory(CATEGORY_SHIELD_BLAST) then return end
		e:GetLabelObject():SetLabel(1)
	end)
	c:RegisterEffect(e2)
	local e3=effect:Clone()
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_CHAIN_END)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL+EFFECT_FLAG_DELAY+prop)
	e3:SetCondition(Auxiliary.ShieldBlastCondition2)
	c:RegisterEffect(e3)
	e1:SetLabelObject(e3)
	e2:SetLabelObject(e3)
end
--cannot be battle target
function Auxiliary.CannotBeBattleTargetCondition(e)
	local c=e:GetHandler()
	if c:IsCanBeUntappedAttacked() then return false end
	return c:IsFaceup() and c:IsUntapped()
end
function Auxiliary.CannotBeBattleTargetValue(e,c)
	--check for "This creature can attack untapped creatures that have "Blocker"."
	local t={c:IsHasEffect(EFFECT_ATTACK_UNTAPPED)}
	local code=0
	for _,te in pairs(t) do
		if te:GetValue()==EFFECT_BLOCKER then code=EFFECT_BLOCKER end
	end
	if code>0 then
		return not e:GetHandler():IsHasEffect(code)
	else
		return not c:IsCanAttackUntapped()
	end
end
--attack shield
function Auxiliary.AttackShieldCondition(e)
	local tp=e:GetHandlerPlayer()
	local c=e:GetHandler()
	return Duel.GetTurnPlayer()==tp and Duel.GetShieldCount(1-tp)>0
		and Duel.GetAttacker()==c and Duel.GetAttackTarget()==nil and c:IsCanBreakShield()
end
function Auxiliary.AttackShieldOperation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.BreakShield(tp,1-tp,1,1,c)
	--ignore yugioh rules
	--no battle damage
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e1:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		Duel.ChangeBattleDamage(1-tp,0)
	end)
	e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
	Duel.RegisterEffect(e1,tp)
end

--evolution procedure
function Auxiliary.AddEvolutionProcedure(c,f1,f2)
	--summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(DESC_EVOLVE)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SUMMON_CREATURE_PROC)
	e1:SetProperty(EFFECT_FLAG_SUMMON_PARAM+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetRange(LOCATION_HAND)
	e1:SetTargetRange(POS_FACEUP_UNTAPPED,0)
	e1:SetCondition(Auxiliary.EvolutionCondition1(f1,f2))
	e1:SetTarget(Auxiliary.EvolutionTarget(f1,f2))
	e1:SetOperation(Auxiliary.EvolutionOperation1)
	e1:SetValue(SUMMON_TYPE_EVOLVE)
	c:RegisterEffect(e1)
	--when played by effect
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(DESC_EVOLVE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_CUSTOM+EVENT_EVOLUTION_TO_BZONE)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
	e2:SetCondition(Auxiliary.EvolutionCondition2(f1,f2))
	e2:SetOperation(Auxiliary.EvolutionOperation2(f1,f2))
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_TO_BZONE_CONDITION)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
	e3:SetCondition(aux.NOT(Auxiliary.EvolutionCondition2(f1,f2)))
	c:RegisterEffect(e3)
end
function Auxiliary.EvolutionFilter1(c,g,f1,f2)
	return c:IsFaceup() and (not f1 or f1(c)) and (not f2 or g:IsExists(Auxiliary.EvolutionFilter2,1,c,f2))
end
function Auxiliary.EvolutionFilter2(c,f)
	return c:IsFaceup() and (not f or f(c))
end
function Auxiliary.EvolutionCondition1(f1,f2)
	return	function(e,c)
				if c==nil then return true end
				local tp=c:GetControler()
				if not c:KJIsSummonable(tp) then return false end
				local g1=Duel.GetMatchingGroup(Auxiliary.ManaZoneFilter(),tp,LOCATION_MZONE,0,nil)
				local g2=Duel.GetFieldGroup(tp,LOCATION_BZONE,0)
				local bzone_count=-1
				if f2 then bzone_count=-2 end
				if Duel.GetLocationCount(tp,LOCATION_BZONE)<bzone_count
					or g1:FilterCount(Card.IsUntapped,nil)<c:GetPlayCost()
					or not g2:IsExists(Auxiliary.EvolutionFilter1,1,nil,g2,f1,f2) then return false end
				return Auxiliary.PayManaCondition(g1,c,c:GetCivilizationCount())
			end
end
function Auxiliary.EvolutionTarget(f1,f2)
	return	function(e,tp,eg,ep,ev,re,r,rp,chk,c)
				local g=Duel.GetFieldGroup(tp,LOCATION_BZONE,0)
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EVOLVE)
				local sg1=g:FilterSelect(tp,Auxiliary.EvolutionFilter1,1,1,nil,g,f1,f2)
				Duel.HintSelection(sg1)
				local tc=sg1:GetFirst()
				local pos=tc:GetPosition()
				if f2 then
					Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EVOLVE)
					local sg2=g:FilterSelect(tp,Auxiliary.EvolutionFilter2,1,1,tc,f2)
					Duel.HintSelection(sg2)
					sg1:Merge(sg2)
				end
				if sg1 then
					sg1:KeepAlive()
					e:SetLabelObject(sg1)
					if not f2 then e:SetTargetRange(pos,0) end
					return true
				else return false end
			end
end
function Auxiliary.EvolutionOperation1(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TAP)
	local g1=Duel.SelectMatchingCard(tp,Card.IsAbleToTap,tp,LOCATION_MZONE,0,c:GetPlayCost(),c:GetPlayCost(),nil)
	Duel.PayManaCost(g1)
	local g2=e:GetLabelObject()
	Duel.PutOnTop(c,g2)
	g2:DeleteGroup()
end
function Auxiliary.EvolutionCondition2(f1,f2)
	return	function(e)
				local tp=e:GetHandler():GetControler()
				local bzone_count=-1
				if f2 then bzone_count=-2 end
				local g=Duel.GetFieldGroup(tp,LOCATION_BZONE,0)
				if Duel.GetLocationCount(tp,LOCATION_BZONE)<bzone_count
					or not g:IsExists(Auxiliary.EvolutionFilter1,1,nil,g,f1,f2) then return false end
				return true
			end
end
function Auxiliary.EvolutionOperation2(f1,f2)
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local g1=Duel.GetFieldGroup(tp,LOCATION_BZONE,0)
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EVOLVE)
				local sg1=g1:FilterSelect(tp,Auxiliary.EvolutionFilter1,1,1,nil,g1,f1,f2)
				Duel.HintSelection(sg1)
				local tc=sg1:GetFirst()
				local pos=tc:GetPosition()
				if f2 then
					Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EVOLVE)
					local sg2=g1:FilterSelect(tp,Auxiliary.EvolutionFilter2,1,1,tc,f2)
					Duel.HintSelection(sg2)
					sg1:Merge(sg2)
				end
				local c=e:GetHandler()
				Duel.PutOnTop(c,sg1)
				Duel.SendtoBZone(c,0,tp,tp,true,false,pos)
			end
end

--spell card
function Auxiliary.EnableSpellAttribute(c)
	--register card info
	Auxiliary.RegisterCardInfo(c)
end

--cast spell procedure
function Auxiliary.AddSpellCastEffect(c,desc_id,targ_func,op_func,prop)
	--c: the spell card that has the ability
	--desc_id: the id of the effect's text (0-15)
	--targ_func: target function
	--op_func: operation function
	--prop: include EFFECT_FLAG_CARD_TARGET for a targeting ability
	prop=prop or 0
	--cast for cost
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(c:GetOriginalCode(),desc_id))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(prop)
	e1:SetRange(LOCATION_HAND)
	e1:SetCost(Auxiliary.CastSpellCost)
	if targ_func then e1:SetTarget(targ_func) end
	e1:SetOperation(op_func)
	c:RegisterEffect(e1)
	--cast for no cost using "shield blast"
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(c:GetOriginalCode(),desc_id))
	e2:SetCategory(CATEGORY_SHIELD_BLAST)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_CUSTOM+EVENT_TRIGGER_SHIELD_BLAST)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL+EFFECT_FLAG_DELAY+prop)
	e2:SetRange(LOCATION_HAND)
	e2:SetCondition(Auxiliary.ShieldBlastCondition1)
	if targ_func then e2:SetTarget(targ_func) end
	e2:SetOperation(op_func)
	c:RegisterEffect(e2)
	--prevent multiple "shield blast" abilities from chaining
	Auxiliary.AddShieldBlastChainLimit(c,e2,prop)
	--cast for no cost without using "shield blast"
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(c:GetOriginalCode(),desc_id))
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_CUSTOM+EVENT_CAST_FREE)
	e3:SetProperty(prop)
	if targ_func then e3:SetTarget(targ_func) end
	e3:SetOperation(op_func)
	c:RegisterEffect(e3)
end
function Auxiliary.CastSpellCost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if c:IsCanCastFree() then return true end
	local cost=c:GetPlayCost()
	local civ_count=c:GetCivilizationCount()
	local g=Duel.GetMatchingGroup(Auxiliary.ManaZoneFilter(Card.IsAbleToTap),tp,LOCATION_MZONE,0,nil)
	if g:GetCount()<cost then return false end
	local b1=g:IsExists(Card.IsCivilization,1,nil,c:GetFirstCivilization())
	local b2=g:IsExists(Card.IsCivilization,1,nil,c:GetSecondCivilization())
	local b3=g:IsExists(Card.IsCivilization,1,nil,c:GetThirdCivilization())
	local b4=g:IsExists(Card.IsCivilization,1,nil,c:GetFourthCivilization())
	local b5=g:IsExists(Card.IsCivilization,1,nil,c:GetFifthCivilization())
	if chk==0 then
		if civ_count==1 then
			return b1
		elseif civ_count==2 then
			return b1 and b2
		elseif civ_count==3 then
			return b1 and b2 and b3
		elseif civ_count==4 then
			return b1 and b2 and b3 and b4
		elseif civ_count==5 then
			return b1 and b2 and b3 and b4 and b5
		end
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TAP)
	local sg=g:FilterSelect(tp,Card.IsAbleToTap,cost,cost,nil)
	Duel.PayManaCost(sg)
end

--functions for non-trigger abilities
--"If this creature would be banished, ABILITY."
--e.g. "Aqua Commando" (2DED 12/55), "Karate Carrot" (2DED 49/55), "Flamewing Phoenix" (9SHA 51/80)
function Auxiliary.AddSingleReplaceEffectBanish(c,desc_id,targ_func,op_func,con_func)
	--c: the card that has the non-trigger ability
	--targ_func: target function (targ_func or Auxiliary.SingleReplaceBanishTarget)
	--op_func: operation function (op_func or Auxiliary.SingleReplaceBanishOperation)
	--con_func: condition function
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(c:GetOriginalCode(),desc_id))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EFFECT_BANISH_REPLACE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_BZONE)
	if con_func then e1:SetCondition(con_func) end
	e1:SetTarget(targ_func)
	if op_func then e1:SetOperation(op_func) end
	c:RegisterEffect(e1)
end
function Auxiliary.SingleReplaceBanishTarget(f,...)
	--f: Card.IsAbleToX
	local ext_params={...}
	return	function(e,tp,eg,ep,ev,re,r,rp,chk)
				local c=e:GetHandler()
				if chk==0 then return not c:IsReason(REASON_REPLACE) and (not f or f(c,table.unpack(ext_params))) end
				return true
			end
end
function Auxiliary.SingleReplaceBanishOperation(f,...)
	--f: Duel.SendtoX
	local ext_params={...}
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local c=e:GetHandler()
				Duel.Hint(HINT_CARD,0,c:GetOriginalCode())
				f(c,table.unpack(ext_params))
			end
end
--"Each time one of your creatures would be banished, ABILITY."
--e.g. "Kronkos, General of Fear" (3RIS 82/165)
function Auxiliary.AddReplaceEffectBanish(c,desc_id,targ_func,op_func,val,con_func)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(c:GetOriginalCode(),desc_id))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EFFECT_BANISH_REPLACE)
	e1:SetRange(LOCATION_BZONE)
	if con_func then e1:SetCondition(con_func) end
	e1:SetTarget(targ_func)
	e1:SetValue(val)
	e1:SetOperation(op_func)
	c:RegisterEffect(e1)
end
--"If a spell or ability would cause you to discard this creature, ABILITY."
--e.g. "Slumbering Titan" (7CLA 69/110)
function Auxiliary.AddSingleReplaceEffectDiscard(c,desc_id,targ_func,op_func)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(c:GetOriginalCode(),desc_id))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EFFECT_SEND_REPLACE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_HAND)
	e1:SetTarget(targ_func)
	e1:SetOperation(op_func)
	c:RegisterEffect(e1)
end
--EFFECT_TYPE_SINGLE trigger abilities
--code: EVENT_ATTACK_ANNOUNCE for "Whenever this creature attacks" (e.g. "Aqua Seneschal" 1TVR 1/43)
--code: EVENT_COME_INTO_PLAY for "When this creature enters the battle zone" (e.g. "Hydro Spy" 1TVR 3/43)
--code: EVENT_CUSTOM+EVENT_BLOCK for "Whenever this creature blocks" (e.g. "Star Lantern" 2DED 9/55)
--code: EVENT_BATTLE_START for "At the start of each battle that includes this creature" (e.g. "Potato Gun Glu-urrgle" 2DED 19/55)
--code: EVENT_BANISHED for "When this creature is banished" (e.g. "Ghost Spy" 2DED 26/55)
--code: EVENT_BATTLE_CONFIRM for "Whenever this creature is attacking and isn't blocked" (e.g. "Death Liger, Apex Predator" 7CLA S3/S10)
--code: EVENT_CHANGE_POS for "Whenever this creature becomes tapped" (e.g. "Onslaught Trooper" 9SHA 29/80)
--code: EVENT_BE_BATTLE_TARGET for "Whenever this creature is attacked" (e.g. "XT-4 Brutefist" 10INV 71/80)
--code: EVENT_CUSTOM+EVENT_BECOME_BLOCKED for "Whenever this creature becomes blocked" (e.g. "Vectron Crawler" 12MYS 54/55)
--code: EVENT_TO_MZONE for "When this creature is put into your mana zone" (e.g. "Anjak, the All-Kin" 13GAU 123/160)
--code: EVENT_BATTLE_CONFIRM for "Whenever this creature attacks your opponent" (e.g. "Worldwaker Omgoth" 15VTX S9/S10)
--con_func: aux.UnblockedCondition for "Whenever this creature is attacking and isn't blocked" (e.g. "Death Liger, Apex Predator" 7CLA S3/S10)
--con_func: aux.SelfTappedCondition for "Whenever this creature becomes tapped" (e.g. "Onslaught Trooper" 9SHA 29/80)
--con_func: aux.SelfLeaveBZoneCondition for "When this creature is put from the battle zone into your mana zone" (e.g. "Anjak, the All-Kin" 13GAU 123/160)
--con_func: aux.AttackPlayerCondition for "Whenever this creature attacks your opponent" (e.g. "Worldwaker Omgoth" 15VTX S9/S10)
function Auxiliary.AddSingleTriggerEffect(c,desc_id,code,optional,targ_func,op_func,prop,con_func,cost_func)
	--optional: true for optional ("you may") abilities
	--cost_func: cost function
	prop=prop or 0
	local typ=optional and EFFECT_TYPE_TRIGGER_O or EFFECT_TYPE_TRIGGER_F
	if typ==EFFECT_TYPE_TRIGGER_O then prop=prop+EFFECT_FLAG_DELAY end
	if code==EVENT_ATTACK_ANNOUNCE then prop=prop+EFFECT_FLAG_CHAIN_LIMIT end
	if code==EVENT_COME_INTO_PLAY then prop=prop+EFFECT_FLAG_COME_INTO_PLAY end
	con_func=con_func or aux.TRUE
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(c:GetOriginalCode(),desc_id))
	e1:SetType(EFFECT_TYPE_SINGLE+typ)
	e1:SetCode(code)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL+prop)
	if cost_func then e1:SetCost(cost_func) end
	e1:SetCondition(con_func)
	if targ_func then e1:SetTarget(targ_func) end
	e1:SetOperation(op_func)
	c:RegisterEffect(e1)
	if code==EVENT_TO_MZONE then
		local e2=e1:Clone()
		e2:SetCode(EVENT_TO_MZONE_TAPPED)
		e2:SetCondition(aux.AND(Auxiliary.SelfTappedCondition,con_func))
		c:RegisterEffect(e2)
	end
end
--EFFECT_TYPE_FIELD trigger abilities
--code: EVENT_BANISHED for "Whenever another creature is banished" (e.g. "Black Feather of Shadow Abyss" 2DED 24/55)
--code: EVENT_PHASE+PHASE_END for "At the end of the turn" (e.g. "Gilaflame the Assaulter" 2DED 40/55)
--code: EVENT_COME_INTO_PLAY for "Whenever one of your creatures enters the battle zone" (e.g. "Starlight Strategist" 3RIS 27/165)
--code: EVENT_UNTAP_STEP for "At the start of the turn" (e.g. "Hokira, Council of Logos" 3RIS 43/165)
--code: EVENT_BATTLE_CONFIRM for "Whenever a creature attacks and isn't blocked" (e.g. "Sasha the Observer" 7CLA S1/S10)
--code: EVENT_ATTACK_ANNOUNCE for "Whenever one of your other creatures attacks" (e.g. "General Finbarr" 7CLA D1/D2)
--code: EVENT_DISCARD for "Whenever [a player] discards a card" (e.g. "Curse-Eye Black Feather" 9SHA 19/80)
--code: EVENT_DRAW for "Whenever [a player] draws a card" (e.g. "Krazzix the Volatile" 9SHA 61/80)
--code: EVENT_LEAVE_BZONE for "Whenever a creature leaves the battle zone" (e.g. "Volcano Trooper" 13GAU 118/160)
--con_func: aux.UnblockedCondition for "Whenever a creature attacks and isn't blocked" (e.g. "Sasha the Observer" 7CLA S1/S10)
--con_func: aux.DiscardHandCondition(PLAYER_OPPO) for "Whenever your opponent discards a card" (e.g. "Curse-Eye Black Feather" 9SHA 19/80)
--con_func: aux.EventPlayerCondition(PLAYER_SELF) for "Whenever you draw a card" (e.g. "Krazzix the Volatile" 9SHA 61/80)
--con_func: aux.EventPlayerCondition(PLAYER_OPPO) for "Whenever your opponent draws a card" (e.g. "Spinning Terror" 10INV 19/80)
function Auxiliary.AddTriggerEffect(c,desc_id,code,optional,targ_func,op_func,prop,con_func)
	prop=prop or 0
	local typ=optional and EFFECT_TYPE_TRIGGER_O or EFFECT_TYPE_TRIGGER_F
	if typ==EFFECT_TYPE_TRIGGER_O then prop=prop+EFFECT_FLAG_DELAY end
	if code==EVENT_ATTACK_ANNOUNCE then prop=prop+EFFECT_FLAG_CHAIN_LIMIT end
	if code==EVENT_COME_INTO_PLAY then prop=prop+EFFECT_FLAG_COME_INTO_PLAY end
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(c:GetOriginalCode(),desc_id))
	e1:SetType(EFFECT_TYPE_FIELD+typ)
	e1:SetCode(code)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL+prop)
	e1:SetRange(LOCATION_BZONE)
	if code==EVENT_PHASE+PHASE_END or code==EVENT_UNTAP_STEP then
		e1:SetCountLimit(1)
	end
	if con_func then e1:SetCondition(con_func) end
	if targ_func then e1:SetTarget(targ_func) end
	e1:SetOperation(op_func)
	c:RegisterEffect(e1)
	return e1
end
--"When this creature wins a battle, ABILITY."
--e.g. "Skeeter Swarmer" (1TVR 19/43)
function Auxiliary.AddSingleTriggerEffectWinBattle(c,desc_id,optional,targ_func,op_func,prop,con_func)
	local typ=optional and EFFECT_TYPE_TRIGGER_O or EFFECT_TYPE_TRIGGER_F
	con_func=con_func or aux.TRUE
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(c:GetOriginalCode(),desc_id))
	e1:SetType(EFFECT_TYPE_SINGLE+typ)
	e1:SetCode(EVENT_BATTLE_BANISHING)
	if prop then e1:SetProperty(prop) end
	e1:SetCondition(aux.AND(Auxiliary.SelfBattleWinCondition,con_func))
	if targ_func then e1:SetTarget(targ_func) end
	e1:SetOperation(op_func)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(c:GetOriginalCode(),desc_id))
	e2:SetType(EFFECT_TYPE_SINGLE+typ)
	e2:SetCode(EVENT_CUSTOM+EVENT_WIN_BATTLE)
	if prop then e2:SetProperty(prop) end
	e2:SetCondition(con_func)
	if targ_func then e2:SetTarget(targ_func) end
	e2:SetOperation(op_func)
	c:RegisterEffect(e2)
end
--"Whenever one of your creatures wins a battle, ABILITY."
--e.g. "Lepidos the Ancient" (4EVO 49/55)
function Auxiliary.AddTriggerEffectWinBattle(c,desc_id,optional,targ_func,op_func,prop,con_func)
	local typ=optional and EFFECT_TYPE_TRIGGER_O or EFFECT_TYPE_TRIGGER_F
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(c:GetOriginalCode(),desc_id))
	e1:SetType(EFFECT_TYPE_FIELD+typ)
	e1:SetCode(EVENT_BATTLE_BANISHING)
	if prop then e1:SetProperty(prop) end
	e1:SetRange(LOCATION_BZONE)
	if con_func then e1:SetCondition(con_func) end
	if targ_func then e1:SetTarget(targ_func) end
	e1:SetOperation(op_func)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_CUSTOM+EVENT_WIN_BATTLE)
	c:RegisterEffect(e2)
end
--"Whenever a player casts a spell, ABILITY."
--e.g. "Spellbane Dragon" (6DSI 44/55)
function Auxiliary.AddTriggerEffectPlayerCastSpell(c,desc_id,p,f,optional,targ_func,op_func,prop)
	--p: the player who casts the spell (PLAYER_SELF, PLAYER_OPPO, or nil for either player)
	--f: filter function if the spell is specified
	prop=prop or 0
	local typ=optional and EFFECT_TYPE_TRIGGER_O or EFFECT_TYPE_TRIGGER_F
	if typ==EFFECT_TYPE_TRIGGER_O then prop=prop+EFFECT_FLAG_DELAY end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_CHAINING)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_BZONE)
	e1:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		e:GetLabelObject():SetLabel(0)
	end)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_CHAIN_SOLVED)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_BZONE)
	e2:SetOperation(Auxiliary.SpellChainSolvedOperation(p,f))
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(c:GetOriginalCode(),desc_id))
	e3:SetType(EFFECT_TYPE_FIELD+typ)
	e3:SetCode(EVENT_CHAIN_END)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL+prop)
	e3:SetRange(LOCATION_BZONE)
	e3:SetCondition(function(e,tp,eg,ep,ev,re,r,rp)
		return e:GetLabel()==1
	end)
	if targ_func then e3:SetTarget(targ_func) end
	e3:SetOperation(op_func)
	c:RegisterEffect(e3)
	e1:SetLabelObject(e3)
	e2:SetLabelObject(e3)
end
function Auxiliary.SpellChainSolvedOperation(p,f)
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local reason_player=(p==PLAYER_SELF and tp) or (p==PLAYER_OPPO and 1-tp)
				local rc=re:GetHandler()
				if reason_player and rp==reason_player and rc:IsSpell() and (not f or f(rc)) then
					e:GetLabelObject():SetLabel(1)
				end
			end
end
--"Whenever a card is put into your mana zone, ABILITY."
--"Whenever a card enters your mana zone, ABILITY."
--"Whenever a card is put into your opponent's mana zone, ABILITY."
--e.g. "Kurragar of the Hordes" (6DSI S5/S5), "Humonguru" (12MYS S4/S5), "Earthbond Giant" (15VTX 128/160)
function Auxiliary.AddTriggerEffectEnterMZone(c,desc_id,p,optional,targ_func,op_func,prop,con_func)
	--p: the player whose card is sent to the mana zone (PLAYER_SELF, PLAYER_OPPO, or nil for either player)
	prop=prop or 0
	local typ=optional and EFFECT_TYPE_TRIGGER_O or EFFECT_TYPE_TRIGGER_F
	if typ==EFFECT_TYPE_TRIGGER_O then prop=prop+EFFECT_FLAG_DELAY end
	con_func=con_func or aux.TRUE
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(c:GetOriginalCode(),desc_id))
	e1:SetType(EFFECT_TYPE_FIELD+typ)
	e1:SetCode(EVENT_TO_MZONE)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL+prop)
	e1:SetRange(LOCATION_BZONE)
	e1:SetCondition(aux.AND(Auxiliary.EnterMZoneUntappedCondition(p),con_func))
	if targ_func then e1:SetTarget(targ_func) end
	e1:SetOperation(op_func)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_TO_MZONE_TAPPED)
	e2:SetCondition(aux.AND(Auxiliary.EnterMZoneTappedCondition(p),con_func))
	c:RegisterEffect(e2)
end
--"Whenever this creature becomes the target of one of your opponent's spells or abilities, ABILITY."
--"Whenever one of your creatures become the target of one of your opponent's spells, ABILITY."
--e.g. "Infernus the Immolator" (7CLA S4/S10), "Dark-Seer Jurlon" (10INV S6/S10)
function Auxiliary.AddTriggerEffectBecomeTarget(c,desc_id,optional,targ_func,op_func,prop,con_func)
	prop=prop or 0
	local typ=optional and EFFECT_TYPE_QUICK_O or EFFECT_TYPE_QUICK_F
	if typ==EFFECT_TYPE_QUICK_O then prop=prop+EFFECT_FLAG_DELAY end
	con_func=con_func or aux.TRUE
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(c:GetOriginalCode(),desc_id))
	e1:SetType(typ)
	e1:SetCode(EVENT_CHAINING)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL+prop)
	e1:SetRange(LOCATION_BZONE)
	e1:SetCondition(aux.AND(Auxiliary.SelfBecomeTargetCondition,con_func))
	if targ_func then e1:SetTarget(targ_func) end
	e1:SetOperation(op_func)
	c:RegisterEffect(e1)
end
--static ability that provides a continuous effect for a card
--e.g. "Frogzooka" (1TVR 2/43), "Ice Blade" (1TVR 5/43), "Blaze Belcher" (1TVR 23/43)
function Auxiliary.EnableEffectCustom(c,code,con_func,s_range,o_range,targ_func)
	--code: EFFECT_BLOCKER, EFFECT_GUARD, EFFECT_SHIELD_BLAST, EFFECT_MUST_ATTACK, etc.
	--s_range: the location of your card to provide the ability to
	--o_range: the location of your opponent's card to provide the ability to
	local e1=Effect.CreateEffect(c)
	if s_range or o_range then
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetRange(LOCATION_BZONE)
		e1:SetTargetRange(s_range,o_range)
		if targ_func then e1:SetTarget(targ_func) end
	else
		e1:SetType(EFFECT_TYPE_SINGLE)
	end
	e1:SetCode(code)
	e1:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	if con_func then e1:SetCondition(con_func) end
	c:RegisterEffect(e1)
end
--add a temporary ability to a card
--e.g. "Overcharge" (1TVR 29/43), "Tatsurion" (1TVR S2/S2), "Chain-Lash Tatsurion" (2DED 35/55)
function Auxiliary.AddTempEffectCustom(c,tc,desc_id,code,reset_flag,reset_count)
	--c: the card that provides the ability
	--tc: the card to provide the ability to
	--code: EFFECT_ATTACK_UNTAPPED, EFFECT_TURN_ATTACK_TAPPED, EFFECT_UNTAPPED_BE_ATTACKED, etc.
	reset_flag=reset_flag or RESET_PHASE+PHASE_END
	if tc==c then reset_flag=reset_flag+RESET_DISABLE end
	reset_count=reset_count or 1
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(c:GetOriginalCode(),desc_id))
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(code)
	e1:SetProperty(EFFECT_FLAG_SET_AVAILABLE+EFFECT_FLAG_CLIENT_HINT)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+reset_flag,reset_count)
	tc:RegisterEffect(e1)
end
--functions for non-keyworded abilities
--"This creature can't be blocked."
--e.g. "King Pontias" (1TVR 7/43)
function Auxiliary.EnableCannotBeBlocked(c,f,con_func)
	con_func=con_func or aux.TRUE
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetRange(LOCATION_BZONE)
	e1:SetTargetRange(1,1)
	e1:SetCondition(aux.AND(Auxiliary.SelfAttackerCondition,con_func))
	e1:SetValue(Auxiliary.CannotBeBlockedValue(f))
	c:RegisterEffect(e1)
end
--f: filter function for "This creature can't be blocked by X creatures."
--e.g. "Roaming Bloodmane" (1TVR 40/43), "Bat-Breath Scaradorable" (2DED S3/S5)
function Auxiliary.CannotBeBlockedValue(f)
	return	function(e,re,tp)
				return re:IsHasCategory(CATEGORY_BLOCKER) and (not f or f(e,re,tp))
			end
end
function Auxiliary.CannotBeBlockedBoolFunction(f,...)
	local ext_params={...}
	return	function(e,re,tp)
				return f(re:GetHandler(),table.unpack(ext_params))
			end
end
--filter for "This creature can't be blocked by creatures that have less power than it."
--e.g. "Roaming Bloodmane" (1TVR 40/43)
function Auxiliary.CannotBeBlockedLessPowerValue(e,re,tp)
	return e:GetHandler():GetPower()>re:GetHandler():GetPower()
end
--"Each of your creatures has "This creature can't be blocked"."
--e.g. "Launcher Locust" (3RIS 146/165)
function Auxiliary.AddStaticEffectCannotBeBlocked(c,s_range,o_range,targ_func,val)
	s_range=s_range or LOCATION_ALL
	o_range=o_range or 0
	targ_func=targ_func or aux.TRUE
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetRange(LOCATION_BZONE)
	e1:SetTargetRange(1,1)
	e1:SetCondition(Auxiliary.SelfAttackerCondition)
	e1:SetValue(Auxiliary.CannotBeBlockedValue(val))
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_GRANT)
	e2:SetRange(LOCATION_BZONE)
	e2:SetTargetRange(s_range,o_range)
	e2:SetTarget(targ_func)
	e2:SetLabelObject(e1)
	c:RegisterEffect(e2)
end
--e.g. "Covering Fire" (3RIS 4/165), "Embolden" (15VTX 129/160)
function Auxiliary.AddTempEffectCannotBeBlocked(c,tc,desc_id,val,con_func,reset_flag,reset_count)
	con_func=con_func or aux.TRUE
	reset_flag=reset_flag or RESET_PHASE+PHASE_END
	if tc==c then reset_flag=reset_flag+RESET_DISABLE end
	reset_count=reset_count or 1
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetRange(LOCATION_BZONE)
	e1:SetTargetRange(1,1)
	e1:SetCondition(aux.AND(Auxiliary.SelfAttackerCondition,con_func))
	e1:SetValue(Auxiliary.CannotBeBlockedValue(val))
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+reset_flag,reset_count)
	tc:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(c:GetOriginalCode(),desc_id))
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_CLIENT_HINT)
	e2:SetCondition(con_func)
	e2:SetReset(RESET_EVENT+RESETS_STANDARD+reset_flag,reset_count)
	tc:RegisterEffect(e2)
end
--"When this creature attacks, banish it at the end of the attack."
--e.g. "Dream Pirate" (1TVR 14/43)
function Auxiliary.EnableAttackEndSelfBanish(c,desc_id)
	desc_id=desc_id or 0
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(c:GetOriginalCode(),desc_id))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_ATTACK_END)
	e1:SetCountLimit(1)
	e1:SetTarget(Auxiliary.AttackEndSelfBanishTarget)
	e1:SetOperation(Auxiliary.SelfBanishOperation)
	c:RegisterEffect(e1)
end
function Auxiliary.AttackEndSelfBanishTarget(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.GetAttacker()==c and c:IsLocation(LOCATION_BZONE) end
end
function Auxiliary.SelfBanishTarget(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():KJIsBanishable() end
end
function Auxiliary.SelfBanishOperation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsLocation(LOCATION_BZONE) and c:IsFaceup() then
		Duel.KJBanish(c,REASON_EFFECT)
	end
end
--"When this creature wins a battle, banish it."
--e.g. "Skeeter Swarmer" (1TVR 19/43)
function Auxiliary.EnableBattleWinSelfBanish(c,desc_id,con_func)
	desc_id=desc_id or 0
	con_func=con_func or aux.TRUE
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(c:GetOriginalCode(),desc_id))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLE_BANISHING)
	e1:SetCondition(aux.AND(Auxiliary.SelfBattleWinCondition,con_func))
	e1:SetOperation(Auxiliary.SelfBanishOperation)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(c:GetOriginalCode(),desc_id))
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_CUSTOM+EVENT_WIN_BATTLE)
	e2:SetCondition(con_func)
	e2:SetOperation(Auxiliary.SelfBanishOperation)
	c:RegisterEffect(e2)
end
--"This creature can attack untapped creatures."
--"This creature can attack untapped creatures that have "Blocker"."
--e.g. "Little Hissy" (1TVR 28/43), "Kuth the Dervish" (15VTX 104/160)
function Auxiliary.EnableAttackUntapped(c,val)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_ATTACK_UNTAPPED)
	if val then e1:SetValue(val) end
	c:RegisterEffect(e1)
end
--"This creature gets +/-N000 power."
--"Each of your/your opponent's creatures gets +/-N000 power."
--e.g. "Quillspike Tatsurion" (2DED D1/D1), "Horrid Stinger" (1TVR 18/43)
function Auxiliary.EnableUpdatePower(c,val,con_func,s_range,o_range,targ_func)
	--con_func: include aux.SelfAttackerCondition for "while this creature is attacking"
	local e1=Effect.CreateEffect(c)
	if s_range or o_range then
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetTargetRange(s_range,o_range)
		if targ_func then e1:SetTarget(targ_func) end
	else
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	end
	e1:SetCode(EFFECT_UPDATE_POWER)
	e1:SetRange(LOCATION_BZONE)
	if con_func then e1:SetCondition(con_func) end
	e1:SetValue(val)
	c:RegisterEffect(e1)
end
--e.g. "Overcharge" (1TVR 29/43)
function Auxiliary.AddTempEffectUpdatePower(c,tc,desc_id,val,reset_flag,reset_count,con_func)
	reset_flag=reset_flag or RESET_PHASE+PHASE_END
	if tc==c then reset_flag=reset_flag+RESET_DISABLE end
	reset_count=reset_count or 1
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(c:GetOriginalCode(),desc_id))
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_POWER)
	e1:SetProperty(EFFECT_FLAG_CLIENT_HINT)
	if con_func then e1:SetCondition(con_func) end
	e1:SetValue(val)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+reset_flag,reset_count)
	tc:RegisterEffect(e1)
end
--"At the end of the turn, [you may] return this creature from the battle zone to your hand."
--e.g. "Gilaflame the Assaulter" (2DED 40/55)
function Auxiliary.EnableTurnEndSelfReturn(c,desc_id,con_func,optional)
	desc_id=desc_id or 0
	local typ=optional and EFFECT_TYPE_TRIGGER_O or EFFECT_TYPE_TRIGGER_F
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(c:GetOriginalCode(),desc_id))
	e1:SetType(EFFECT_TYPE_FIELD+typ)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetRange(LOCATION_BZONE)
	e1:SetCountLimit(1)
	if con_func then e1:SetCondition(con_func) end
	if typ==EFFECT_TYPE_TRIGGER_O then
		e1:SetTarget(Auxiliary.SelfReturnTarget)
	end
	e1:SetOperation(Auxiliary.SelfReturnOperation)
	c:RegisterEffect(e1)
end
function Auxiliary.SelfReturnTarget(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToHand() end
end
function Auxiliary.SelfReturnOperation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsLocation(LOCATION_BZONE) and c:IsFaceup() then
		Duel.SendtoHand(c,PLAYER_OWNER,REASON_EFFECT)
	end
end
--"At the end of each of your turns, you may untap this creature."
--e.g. "Nimbus Scout" (3RIS 15/165)
function Auxiliary.EnableTurnEndSelfUntap(c,desc_id)
	desc_id=desc_id or 0
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(c:GetOriginalCode(),desc_id))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetRange(LOCATION_BZONE)
	e1:SetCondition(Auxiliary.TurnPlayerCondition(PLAYER_SELF))
	e1:SetTarget(Auxiliary.SelfUntapTarget)
	e1:SetOperation(Auxiliary.SelfUntapOperation)
	c:RegisterEffect(e1)
end
function Auxiliary.SelfUntapTarget(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsFaceup() and c:IsAbleToUntap() end
end
function Auxiliary.SelfUntapOperation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsAbleToUntap() then
		Duel.Untap(c,REASON_EFFECT)
	end
end
--"This creature can't be attacked"
--"Your creatures can't be attacked."
--e.g. "Bat-Breath Scaradorable" (2DED S3/S5), "Bristling Tatsurion" (13/PRM8), "Lava Leaper" (4EVO 43/55)
function Auxiliary.EnableCannotBeAttacked(c,f,con_func,s_range,o_range,targ_func)
	--f: filter function for "This creature can't be attacked by X creatures."
	local e1=Effect.CreateEffect(c)
	if s_range or o_range then
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetTargetRange(s_range,o_range)
		if targ_func then e1:SetTarget(targ_func) end
	else
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	end
	e1:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	e1:SetRange(LOCATION_BZONE)
	if con_func then e1:SetCondition(con_func) end
	e1:SetValue(Auxiliary.CannotBeAttackedValue(f))
	c:RegisterEffect(e1)
end
function Auxiliary.CannotBeAttackedValue(f)
	return	function(e,c)
				return not f or f(e,c)
			end
end
--"This creature can't be the target of your opponent's spells and abilities."
--e.g. "King Neptas" (4EVO 17/55)
function Auxiliary.EnableCannotBeTargeted(c,con_func)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_BZONE)
	if con_func then e1:SetCondition(con_func) end
	e1:SetValue(aux.tgoval)
	c:RegisterEffect(e1)
end
--"This creature can't attack creatures."
--e.g. "Forsett, Heroic Shaman" (4EVO 46/55)
function Auxiliary.EnableCannotAttackCreature(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e1:SetValue(aux.TargetBoolFunction(Card.IsCreature))
	c:RegisterEffect(e1)
	Auxiliary.EnableEffectCustom(c,EFFECT_CANNOT_ATTACK_CREATURE)
end
--"A player taps N less mana cards to summon creatures."
--"Tap N less mana cards to summon this creature."
--Not fully implemented: Levels can be reduced to 0
--e.g. "Lux" (6DSI 6/55), "The Reviled" (10INV 57/80)
function Auxiliary.EnableUpdatePlayCost(c,val,con_func,s_range,o_range,targ_func)
	local e1=Effect.CreateEffect(c)
	if s_range or o_range then
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetRange(LOCATION_BZONE)
		e1:SetTargetRange(s_range,o_range)
		if targ_func then e1:SetTarget(targ_func) end
	else
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
		e1:SetRange(LOCATION_HAND+LOCATION_BZONE)
	end
	e1:SetCode(EFFECT_UPDATE_PLAY_COST)
	if con_func then e1:SetCondition(con_func) end
	e1:SetValue(val)
	c:RegisterEffect(e1)
end
--e.g. "Nimbus, Regent's Envoy" (16EYE 9/80)
function Auxiliary.AddTempEffectChangeManaCost(c,tc,desc_id,val,reset_flag,reset_count)
	reset_flag=reset_flag or RESET_PHASE+PHASE_END
	if tc==c then reset_flag=reset_flag+RESET_DISABLE end
	reset_count=reset_count or 1
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(c:GetOriginalCode(),desc_id))
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CHANGE_MANA_COST)
	e1:SetProperty(EFFECT_FLAG_CLIENT_HINT)
	e1:SetValue(val)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+reset_flag,reset_count)
	tc:RegisterEffect(e1)
end
--"This creature wins all its battles."
--e.g. "Ra-Vu the Indomitable" (9SHA 5/80)
function Auxiliary.EnableWinsAllBattles(c,desc_id)
	desc_id=desc_id or 0
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(c:GetOriginalCode(),desc_id))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_BATTLE_START)
	e1:SetCondition(Auxiliary.WinsAllBattlesCondition)
	e1:SetOperation(Auxiliary.WinsAllBattlesOperation)
	c:RegisterEffect(e1)
	Auxiliary.EnableEffectCustom(c,EFFECT_WINS_ALL_BATTLES)
end
function Auxiliary.WinsAllBattlesCondition(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetHandler():GetBattleTarget()
	return tc and tc:IsFaceup() and tc:IsControler(1-tp)
end
function Auxiliary.WinsAllBattlesOperation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.Hint(HINT_CARD,0,c:GetOriginalCode())
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	local tc=c:GetBattleTarget()
	if c:IsHasEffect(EFFECT_WINS_ALL_BATTLES) and tc:IsHasEffect(EFFECT_WINS_ALL_BATTLES) then
		--neither creature is banished
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UNBANISHABLE_BATTLE)
		e1:SetValue(1)
		e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
		c:RegisterEffect(e1)
		local e2=e1:Clone()
		tc:RegisterEffect(e2)
	else
		--raise event for "When this creature wins a battle"
		Duel.RaiseSingleEvent(c,EVENT_CUSTOM+EVENT_WIN_BATTLE,e,0,0,0,0)
		--raise event for "Whenever one of your creatures wins a battle"
		Duel.RaiseEvent(c,EVENT_CUSTOM+EVENT_WIN_BATTLE,e,0,0,0,0)
		--(reserved) raise event for "When this creature loses a battle"
		--Duel.RaiseSingleEvent(tc,EVENT_CUSTOM+EVENT_LOSE_BATTLE,e,0,0,0,0)
		--raise event for "Whenever one of your creatures loses a battle"
		Duel.RaiseEvent(tc,EVENT_CUSTOM+EVENT_LOSE_BATTLE,e,0,0,0,0)
		Duel.KJBanish(tc,REASON_RULE)
	end
end
--"This creature loses all its battles."
--e.g. "Hollow Worm" (15VTX 73/160)
function Auxiliary.EnableLosesAllBattles(c,desc_id)
	desc_id=desc_id or 0
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(c:GetOriginalCode(),desc_id))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_BATTLE_START)
	e1:SetCondition(Auxiliary.LosesAllBattlesCondition)
	e1:SetOperation(Auxiliary.LosesAllBattlesOperation)
	c:RegisterEffect(e1)
end
function Auxiliary.LosesAllBattlesCondition(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetHandler():GetBattleTarget()
	return tc and tc:IsFaceup() and tc:IsControler(1-tp)
end
function Auxiliary.LosesAllBattlesOperation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.Hint(HINT_CARD,0,c:GetOriginalCode())
	local tc=c:GetBattleTarget()
	--enemy creature is not banished
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UNBANISHABLE_BATTLE)
	e1:SetValue(1)
	e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
	tc:RegisterEffect(e1)
	Duel.KJBanish(c,REASON_EFFECT+REASON_BATTLE)
end
--"Each time one of your opponent's creatures attacks, it attacks this creature if able."
--e.g. "Ninja Pumpkin" (9SHA 37/80)
function Auxiliary.EnableMustBeAttacked(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_MUST_ATTACK)
	e1:SetRange(LOCATION_BZONE)
	e1:SetTargetRange(0,LOCATION_BZONE)
	e1:SetCondition(Auxiliary.SelfTappedCondition)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_MUST_ATTACK_CREATURE)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_MUST_BE_ATTACKED)
	e3:SetCondition(Auxiliary.SelfTappedCondition)
	e3:SetValue(1)
	c:RegisterEffect(e3)
end
--"All your creatures in the battle zone are CREATURE TYPE creatures in addition to their other creature types."
--e.g. "Bad Apple" (10INV 62/80)
function Auxiliary.EnableAddRace(c,val,s_range,o_range,targ_func)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_ADD_CREATURE_RACE)
	e1:SetRange(LOCATION_BZONE)
	e1:SetTargetRange(s_range,o_range)
	if targ_func then e1:SetTarget(targ_func) end
	e1:SetValue(val)
	c:RegisterEffect(e1)
end
--e.g. "Regent Sasha" (13GAU S2/S10)
function Auxiliary.AddTempEffectCannotLeaveBZone(c,tc,desc_id,reset_flag,reset_count)
	reset_flag=reset_flag or RESET_PHASE+PHASE_END
	if tc==c then reset_flag=reset_flag+RESET_DISABLE end
	reset_count=reset_count or 1
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(c:GetOriginalCode(),desc_id))
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_TO_HAND)
	e1:SetProperty(EFFECT_FLAG_CLIENT_HINT)
	e1:SetRange(LOCATION_BZONE)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+reset_flag,reset_count)
	tc:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_CANNOT_TO_DECK)
	tc:RegisterEffect(e2)
	local e3=e1:Clone()
	e3:SetCode(EFFECT_CANNOT_TO_DPILE)
	tc:RegisterEffect(e3)
	local e4=e1:Clone()
	e4:SetCode(EFFECT_CANNOT_TO_MZONE)
	tc:RegisterEffect(e4)
	Auxiliary.AddTempEffectCustom(c,tc,desc_id,EFFECT_CANNOT_TO_SZONE,reset_flag,reset_count)
end
--"This creature can't be banished."
--e.g. "Virtuous Alcadeus" (15VTX 29/160)
function Auxiliary.EnableCannotBeBanished(c,s_range,o_range,targ_func)
	local e1=Effect.CreateEffect(c)
	if s_range or o_range then
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetRange(LOCATION_BZONE)
		e1:SetTargetRange(s_range,o_range)
		if targ_func then e1:SetTarget(targ_func) end
	else
		e1:SetType(EFFECT_TYPE_SINGLE)
	end
	e1:SetCode(EFFECT_UNBANISHABLE)
	e1:SetCondition(function(e)
		return e:GetHandler():GetPower()>0
	end)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_UNBANISHABLE_BATTLE)
	c:RegisterEffect(e2)
	local e3=e1:Clone()
	e3:SetCode(EFFECT_UNBANISHABLE_EFFECT)
	c:RegisterEffect(e3)
end
--"While revealed for a clash, this card is level N."
--e.g. "Nimbus, Regent's Envoy" (16EYE 9/80)
function Auxiliary.EnableChangeClashManaCost(c,desc_id,val)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_CUSTOM+EVENT_CLASH)
	e1:SetOperation(Auxiliary.ChangeClashManaCostOperation(desc_id,val))
	c:RegisterEffect(e1)
end
function Auxiliary.ChangeClashManaCostOperation(desc_id,val)
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local c=e:GetHandler()
				Auxiliary.AddTempEffectChangeManaCost(c,c,desc_id,val,RESET_CHAIN)
			end
end
--functions for keyworded abilities
--"Blocker (You may tap this creature to change an enemy creature's attack to this creature.)"
--e.g. "Frogzooka" (1TVR 2/43)
function Auxiliary.EnableBlocker(c,con_func)
	con_func=con_func or aux.TRUE
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(DESC_BLOCKER)
	e1:SetCategory(CATEGORY_BLOCKER)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetRange(LOCATION_BZONE)
	e1:SetCondition(aux.AND(Auxiliary.BlockerCondition,con_func))
	e1:SetCost(Auxiliary.BlockerCost)
	e1:SetTarget(Auxiliary.BlockerTarget)
	e1:SetOperation(Auxiliary.BlockerOperation)
	c:RegisterEffect(e1)
	Auxiliary.EnableEffectCustom(c,EFFECT_BLOCKER,con_func)
end
function Auxiliary.BlockerCondition(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttackTarget()
	if tc and tc==e:GetHandler() then return false end
	return Duel.GetAttacker():GetControler()~=tp
end
function Auxiliary.BlockerCost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsFaceup() and c:IsAbleToTap() and Duel.GetFlagEffect(tp,EFFECT_BLOCKER)==0 end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	Duel.RegisterFlagEffect(tp,EFFECT_BLOCKER,RESET_CHAIN,0,1)
end
function Auxiliary.BlockerTarget(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsCanBlock(tp) end
end
function Auxiliary.BlockerOperation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.Tap(c,REASON_EFFECT)
	local tc=Duel.GetAttacker()
	if not tc or tc:IsStatus(STATUS_ATTACK_CANCELED) then return end
	Duel.Tap(tc,REASON_RULE) --fix creature not being tapped when attacking
	Duel.NegateAttack()
	--register Card.IsBlocked
	tc:RegisterFlagEffect(EFFECT_BLOCKED,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_DAMAGE,0,1)
	--add blocked prompt
	Duel.Hint(HINT_OPSELECTED,1-tp,DESC_BLOCKED)
	--register Duel.GetBlocker
	c:RegisterFlagEffect(EFFECT_BLOCKER,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_DAMAGE,0,1)
	--raise event for "Whenever this creature blocks"
	Duel.RaiseSingleEvent(c,EVENT_CUSTOM+EVENT_BLOCK,e,0,0,0,0)
	--raise event for "Whenever this creature becomes blocked"
	Duel.RaiseSingleEvent(tc,EVENT_CUSTOM+EVENT_BECOME_BLOCKED,e,0,0,0,0)
	Duel.BreakEffect()
	Duel.DoBattle(tc,c)
end
--"Each of your creatures has "Blocker"."
--e.g. "Ra-Vu the Stormbringer" (4EVO D1/D1)
function Auxiliary.AddStaticEffectBlocker(c,s_range,o_range,targ_func)
	s_range=s_range or LOCATION_ALL
	o_range=o_range or 0
	targ_func=targ_func or aux.TRUE
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(DESC_BLOCKER)
	e1:SetCategory(CATEGORY_BLOCKER)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetRange(LOCATION_BZONE)
	e1:SetCondition(Auxiliary.BlockerCondition)
	e1:SetCost(Auxiliary.BlockerCost)
	e1:SetTarget(Auxiliary.BlockerTarget)
	e1:SetOperation(Auxiliary.BlockerOperation)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_GRANT)
	e2:SetRange(LOCATION_BZONE)
	e2:SetTargetRange(s_range,o_range)
	e2:SetTarget(targ_func)
	e2:SetLabelObject(e1)
	c:RegisterEffect(e2)
	Auxiliary.EnableEffectCustom(c,EFFECT_BLOCKER,nil,s_range,o_range,targ_func)
end
--e.g. "Defense Mode" (6DSI 4/55)
function Auxiliary.AddTempEffectBlocker(c,tc,desc_id,reset_flag,reset_count)
	reset_flag=reset_flag or RESET_PHASE+PHASE_END
	if tc==c then reset_flag=reset_flag+RESET_DISABLE end
	reset_count=reset_count or 1
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(DESC_BLOCKER)
	e1:SetCategory(CATEGORY_BLOCKER)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetRange(LOCATION_BZONE)
	e1:SetCondition(Auxiliary.BlockerCondition)
	e1:SetTarget(Auxiliary.BlockerTarget)
	e1:SetOperation(Auxiliary.BlockerOperation)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+reset_flag,reset_count)
	tc:RegisterEffect(e1)
	Auxiliary.AddTempEffectCustom(c,tc,desc_id,EFFECT_BLOCKER,reset_flag,reset_count)
end
--"Guard (This creature can't attack.)"
--e.g. "Frogzooka" (1TVR 2/43)
function Auxiliary.EnableGuard(c,con_func)
	con_func=con_func or aux.TRUE
	Auxiliary.EnableEffectCustom(c,EFFECT_CANNOT_ATTACK,aux.AND(Auxiliary.GuardCondition,con_func))
	Auxiliary.EnableEffectCustom(c,EFFECT_GUARD,con_func)
end
function Auxiliary.GuardCondition(e)
	return not e:GetHandler():IsHasEffect(EFFECT_IGNORE_GUARD)
end
--"Shield Blast (Instead of putting this spell into your hand from a broken shield, you may cast it for free.)"
--"Shield Blast (Instead of putting this creature into your hand from a broken shield, you may summon it for free.)"
--e.g. "Ice Blade" (1TVR 5/43), "Flux Drone" (13GAU 8/160)
function Auxiliary.EnableShieldBlast(c,con_func)
	con_func=con_func or aux.TRUE
	Auxiliary.EnableEffectCustom(c,EFFECT_SHIELD_BLAST,con_func)
end
function Auxiliary.ShieldBlastCondition1(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsHasEffect(EFFECT_SHIELD_BLAST)
end
function Auxiliary.ShieldBlastCondition2(e,tp,eg,ep,ev,re,r,rp)
	return Auxiliary.ShieldBlastCondition1(e,tp,eg,ep,ev,re,r,rp) and e:GetLabel()==1 and e:GetHandler():IsBrokenShield()
end
function Auxiliary.ShieldBlastSummonTarget(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():KJIsSummonable(tp) end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
end
function Auxiliary.ShieldBlastSummonOperation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SendtoBZone(c,SUMMON_TYPE_NONEVOLVE,tp,tp,false,false,POS_FACEUP_UNTAPPED)
	end
end
--"Breaker (This creature breaks N shields.)"
--"Each of your creatures has "Breaker"."
--e.g. "Gigargon" (1TVR 16/43), "Starseed Squadron" (7CLA 84/110)
function Auxiliary.EnableBreaker(c,code,con_func,s_range,o_range,targ_func)
	--code: EFFECT_DOUBLE_BREAKER, EFFECT_TRIPLE_BREAKER or EFFECT_WORLD_BREAKER
	con_func=con_func or aux.TRUE
	Auxiliary.EnableEffectCustom(c,EFFECT_BREAKER,con_func,s_range,o_range,targ_func)
	Auxiliary.EnableEffectCustom(c,code,con_func,s_range,o_range,targ_func)
end
--e.g. "Lord Skycrusher" (2DED S4/S5)
function Auxiliary.AddTempEffectBreaker(c,tc,desc_id,code,reset_flag,reset_count)
	reset_flag=reset_flag or RESET_PHASE+PHASE_END
	reset_count=reset_count or 1
	Auxiliary.AddTempEffectCustom(c,tc,desc_id,EFFECT_BREAKER,reset_flag,reset_count)
	Auxiliary.AddTempEffectCustom(c,tc,desc_id,code,reset_flag,reset_count)
end
--"Slayer (When this creature loses a battle, banish the other creature.)"
--e.g. "Skull Cutter" (1TVR 20/43)
function Auxiliary.EnableSlayer(c,con_func)
	con_func=con_func or aux.TRUE
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(DESC_SLAYER)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_ATTACK_END)
	e1:SetCondition(aux.AND(Auxiliary.SlayerCondition,con_func))
	e1:SetTarget(Auxiliary.HintTarget)
	e1:SetOperation(Auxiliary.SlayerOperation)
	c:RegisterEffect(e1)
	Auxiliary.EnableEffectCustom(c,EFFECT_SLAYER,con_func)
end
function Auxiliary.SlayerCondition(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetHandler():GetBattleTarget()
	e:SetLabelObject(tc)
	return tc and tc:IsRelateToBattle()
end
function Auxiliary.SlayerOperation(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	if tc:IsRelateToBattle() then
		Duel.KJBanish(tc,REASON_EFFECT)
	end
end
--"Each of your creatures has "Slayer"."
--e.g. "Umbra" (6DSI 33/55)
function Auxiliary.AddStaticEffectSlayer(c,s_range,o_range,targ_func)
	s_range=s_range or LOCATION_ALL
	o_range=o_range or 0
	targ_func=targ_func or aux.TRUE
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(DESC_SLAYER)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_ATTACK_END)
	e1:SetCondition(Auxiliary.SlayerCondition)
	e1:SetTarget(Auxiliary.HintTarget)
	e1:SetOperation(Auxiliary.SlayerOperation)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_GRANT)
	e2:SetRange(LOCATION_BZONE)
	e2:SetTargetRange(s_range,o_range)
	e2:SetTarget(targ_func)
	e2:SetLabelObject(e1)
	c:RegisterEffect(e2)
	Auxiliary.EnableEffectCustom(c,EFFECT_SLAYER,nil,s_range,o_range,targ_func)
end
--e.g. "Quakes the Unclean" (3RIS 84/165)
function Auxiliary.AddTempEffectSlayer(c,tc,desc_id,reset_flag,reset_count)
	reset_flag=reset_flag or RESET_PHASE+PHASE_END
	if tc==c then reset_flag=reset_flag+RESET_DISABLE end
	reset_count=reset_count or 1
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(DESC_SLAYER)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_ATTACK_END)
	e1:SetCondition(Auxiliary.SlayerCondition)
	e1:SetTarget(Auxiliary.HintTarget)
	e1:SetOperation(Auxiliary.SlayerOperation)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD-RESET_TODPILE-RESET_LEAVE+reset_flag,reset_count)
	tc:RegisterEffect(e1)
	Auxiliary.AddTempEffectCustom(c,tc,desc_id,EFFECT_SLAYER,-RESET_TODPILE-RESET_LEAVE+reset_flag,reset_count)
end
--"Powerful Attack +N000 (While attacking, this creature gets +N000 power.)"
--e.g. "Flametropus" (1TVR 26/43)
function Auxiliary.EnablePowerfulAttack(c,val,con_func)
	con_func=con_func or aux.TRUE
	Auxiliary.EnableUpdatePower(c,val,aux.AND(Auxiliary.SelfAttackerCondition,con_func))
	Auxiliary.EnableEffectCustom(c,EFFECT_POWERFUL_ATTACK,con_func)
end
--"Each of your creatures has "Powerful Attack +N000"."
--e.g. "Twin-Cannon Maelstrom" (4EVO 44/55)
function Auxiliary.AddStaticEffectPowerfulAttack(c,val,s_range,o_range,targ_func,con_func)
	s_range=s_range or LOCATION_ALL
	o_range=o_range or 0
	targ_func=targ_func or aux.TRUE
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_POWER)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_BZONE)
	e1:SetCondition(Auxiliary.SelfAttackerCondition)
	e1:SetValue(val)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_GRANT)
	e2:SetRange(LOCATION_BZONE)
	e2:SetTargetRange(s_range,o_range)
	if con_func then e2:SetCondition(con_func) end
	e2:SetTarget(targ_func)
	e2:SetLabelObject(e1)
	c:RegisterEffect(e2)
	Auxiliary.EnableEffectCustom(c,EFFECT_POWERFUL_ATTACK,nil,s_range,o_range,targ_func)
end
--e.g. "Flame Aura" (3RIS 110/165)
function Auxiliary.AddTempEffectPowerfulAttack(c,tc,desc_id,val,reset_flag,reset_count)
	reset_flag=reset_flag or RESET_PHASE+PHASE_END
	reset_count=reset_count or 1
	Auxiliary.AddTempEffectUpdatePower(c,tc,desc_id,val,reset_flag,reset_count,Auxiliary.SelfAttackerCondition)
	Auxiliary.AddTempEffectCustom(c,tc,desc_id,EFFECT_POWERFUL_ATTACK,reset_flag,reset_count)
end
--"Skirmisher (This creature can attack only creatures.)"
--e.g. "Grand Gure, Tower Keeper" (2DED 2/55)
function Auxiliary.EnableSkirmisher(c,con_func)
	con_func=con_func or aux.TRUE
	Auxiliary.EnableEffectCustom(c,EFFECT_CANNOT_ATTACK_PLAYER,aux.AND(Auxiliary.SkirmisherCondition,con_func))
	Auxiliary.EnableEffectCustom(c,EFFECT_SKIRMISHER,con_func)
end
function Auxiliary.SkirmisherCondition(e)
	return not e:GetHandler():IsHasEffect(EFFECT_IGNORE_SKIRMISHER)
end
--"Protector (You may tap this creature to change an attack on one of your other creatures to this creature.)"
--e.g. "Galsaur" (10INV 26/80)
function Auxiliary.EnableProtector(c)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(DESC_PROTECTOR)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetRange(LOCATION_BZONE)
	e1:SetCondition(Auxiliary.ProtectorCondition)
	e1:SetCost(Auxiliary.ProtectorCost)
	e1:SetOperation(Auxiliary.ProtectorOperation)
	c:RegisterEffect(e1)
	Auxiliary.EnableEffectCustom(c,EFFECT_PROTECTOR,Auxiliary.ProtectorCondition)
end
function Auxiliary.ProtectorCondition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker():GetControler()~=tp and Duel.GetAttackTarget()~=nil and Duel.GetAttackTarget()~=e:GetHandler()
end
function Auxiliary.ProtectorCost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsFaceup() and c:IsAbleToTap() and Duel.GetFlagEffect(tp,EFFECT_PROTECTOR)==0 end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	Duel.RegisterFlagEffect(tp,EFFECT_PROTECTOR,RESET_CHAIN,0,1)
end
function Auxiliary.ProtectorOperation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.Tap(c,REASON_EFFECT)
	local tc=Duel.GetAttacker()
	if not tc or tc:IsStatus(STATUS_ATTACK_CANCELED) then return end
	if Duel.ChangeAttackTarget(c) then
		Duel.DoBattle(c,tc)
	end
end
--"Each of your creatures has "Protector"."
--e.g. "Shaman of the Vigil" (P15/Y2)
function Auxiliary.AddStaticEffectProtector(c,s_range,o_range,targ_func)
	s_range=s_range or LOCATION_ALL
	o_range=o_range or 0
	targ_func=targ_func or aux.TRUE
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(DESC_PROTECTOR)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetRange(LOCATION_BZONE)
	e1:SetCondition(Auxiliary.ProtectorCondition)
	e1:SetCost(Auxiliary.ProtectorCost)
	e1:SetOperation(Auxiliary.ProtectorOperation)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_GRANT)
	e2:SetRange(LOCATION_BZONE)
	e2:SetTargetRange(s_range,o_range)
	e2:SetTarget(targ_func)
	e2:SetLabelObject(e1)
	c:RegisterEffect(e2)
	Auxiliary.EnableEffectCustom(c,EFFECT_PROTECTOR,nil,s_range,o_range,targ_func)
end
--"Unleash (To use a creature's "Unleash" ability, put a card from under it into your discard pile when it attacks.)"
--e.g. "Magistrate Jazuri" (13GAU 16/160)
function Auxiliary.EnableUnleash(c,desc_id,targ_func,op_func,prop,con_func)
	Auxiliary.AddSingleTriggerEffect(c,desc_id,EVENT_ATTACK_ANNOUNCE,true,targ_func,op_func,prop,con_func,Auxiliary.UnleashCost)
	Auxiliary.EnableEffectCustom(c,EFFECT_UNLEASH,con_func)
end
function Auxiliary.UnleashCost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local g=c:GetUnderlyingGroup()
	if chk==0 then return g:IsExists(Card.KJIsAbleToDPile,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODPILE)
	local sg=g:FilterSelect(tp,Card.KJIsAbleToDPile,1,1,nil)
	Duel.KJSendtoDPile(sg,REASON_COST)
	sg:GetFirst():RegisterFlagEffect(EFFECT_UNLEASH,RESET_EVENT+RESETS_STANDARD-RESET_TODPILE,0,1,c:GetCode())
end
--"Powerful Block +N (While blocking, this creature gets +N power.)"
--e.g. "Steadfast Vorwhal" (13GAU 52/160)
function Auxiliary.EnablePowerfulBlock(c,val)
	Auxiliary.EnableUpdatePower(c,val,Auxiliary.SelfBlockCondition)
	Auxiliary.EnableEffectCustom(c,EFFECT_POWERFUL_BLOCK)
end
--"Trapper (When a creature wins a battle against this creature, put that creature into your opponent's mana zone.)"
--e.g. "Essence Boar" (16EYE 56/80)
function Auxiliary.EnableTrapper(c)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(DESC_TRAPPER)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_ATTACK_END)
	e1:SetCondition(Auxiliary.TrapperCondition)
	e1:SetTarget(Auxiliary.HintTarget)
	e1:SetOperation(Auxiliary.TrapperOperation)
	c:RegisterEffect(e1)
	Auxiliary.EnableEffectCustom(c,EFFECT_TRAPPER)
end
function Auxiliary.TrapperCondition(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetHandler():GetBattleTarget()
	e:SetLabelObject(tc)
	return tc and tc:IsRelateToBattle()
end
function Auxiliary.TrapperOperation(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	if tc:IsRelateToBattle() then
		Duel.SendtoMZone(tc,POS_FACEUP_UNTAPPED,REASON_EFFECT)
	end
end
--operation for abilities that target cards
--f: Duel.KJBanish to banish cards
--f: Duel.SendtoDeck to send cards to the deck
--f: Duel.SendtoMZone to send cards to the mana zone
--f: Duel.Tap to tap cards
--f: Duel.Untap to untap cards
function Auxiliary.TargetCardsOperation(f,...)
	local ext_params={...}
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
				if g:GetCount()>0 then
					f(g,table.unpack(ext_params))
				end
			end
end
--Banish
--operation for abilities that banish cards
function Auxiliary.BanishOperation(p,f,s,o,min,max,ex,...)
	--p,min,max: nil to banish all cards
	local ext_params={...}
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local player=(p==PLAYER_SELF and tp) or (p==PLAYER_OPPO and 1-tp)
				max=max or min
				local g=Duel.GetMatchingGroup(aux.AND(Card.KJIsBanishable,f),tp,s,o,ex,table.unpack(ext_params))
				if g:GetCount()==0 then return end
				if e:IsHasType(EFFECT_TYPE_CONTINUOUS) then Duel.Hint(HINT_CARD,0,e:GetHandler():GetOriginalCode()) end
				if min and max then
					Duel.Hint(HINT_SELECTMSG,player,HINTMSG_BANISH)
					local sg=g:Select(player,min,max,ex,table.unpack(ext_params))
					local hg=sg:Filter(Card.IsLocation,nil,LOCATION_BZONE)
					Duel.HintSelection(hg)
					Duel.KJBanish(sg,REASON_EFFECT)
				else
					Duel.KJBanish(g,REASON_EFFECT)
				end
			end
end
--target for abilities that target any number of creatures that have total power N000 or less
function Auxiliary.TargetTotalPowerBelowFilter(c,e,pwr,f,...)
	return c:IsFaceup() and c:IsPowerAbove(0) and c:IsPowerBelow(pwr)
		and c:IsCanBeEffectTarget(e) and (not f or f(c,e,pwr,...))
end
function Auxiliary.TargetTotalPowerBelowTarget(p,s,o,pwr,desc,f,ex,...)
	local ext_params={...}
	return	function(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
				local player=(p==PLAYER_SELF and tp) or (p==PLAYER_OPPO and 1-tp)
				desc=desc or HINTMSG_TARGET
				local g=Duel.GetMatchingGroup(Auxiliary.TargetTotalPowerBelowFilter,tp,s,o,ex,e,pwr,f,table.unpack(ext_params))
				if chkc then return false end
				if chk==0 then
					if e:IsHasType(EFFECT_TYPE_TRIGGER_F) or e:IsHasType(EFFECT_TYPE_QUICK_F) or e:GetHandler():IsSpell() then return true end
					return g:GetCount()>0
				end
				local tg=Group.CreateGroup()
				repeat
					Duel.Hint(HINT_SELECTMSG,player,desc)
					local tc=g:Select(player,0,1,ex):GetFirst()
					if not tc then break end
					Duel.SetTargetCard(tc)
					tg:AddCard(tc)
					pwr=pwr-tc:GetPower()
					g=g:Filter(Auxiliary.TargetTotalPowerBelowFilter,ex,e,pwr,f,table.unpack(ext_params))
				until pwr<=0 or g:GetCount()==0
			end
end
--Shield Break
--operation for abilities that break shields
function Auxiliary.BreakOperation(sp,tgp,min,max,rc)
	--rc: the creature that breaks the shield
	--sp,min,max: nil to break all shields
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local sel_player=(sp==PLAYER_SELF and tp) or (sp==PLAYER_OPPO and 1-tp)
				local target_player=(tgp==PLAYER_SELF and tp) or (tgp==PLAYER_OPPO and 1-tp)
				max=max or min
				rc=rc or e:GetHandler()
				if Duel.GetShieldCount(target_player)==0 then return end
				if e:IsHasType(EFFECT_TYPE_CONTINUOUS) then Duel.Hint(HINT_CARD,0,e:GetHandler():GetOriginalCode()) end
				Duel.BreakShield(sel_player,target_player,min,max,rc,REASON_EFFECT)
			end
end
--Cast For Free
--operation for abilities that cast spells for no cost
function Auxiliary.CastOperation(p,f,s,o,min,max,ex,...)
	--p,min,max: nil to cast all spells for no cost
	local ext_params={...}
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local player=(p==PLAYER_SELF and tp) or (p==PLAYER_OPPO and 1-tp)
				max=max or min
				local g=Duel.GetMatchingGroup(aux.AND(Card.IsSpell,f),tp,s,o,ex,table.unpack(ext_params))
				if g:GetCount()==0 then return end
				if e:IsHasType(EFFECT_TYPE_CONTINUOUS) then Duel.Hint(HINT_CARD,0,e:GetHandler():GetOriginalCode()) end
				if min and max then
					Duel.Hint(HINT_SELECTMSG,player,HINTMSG_CASTFREE)
					local sg=g:Select(player,min,max,ex,table.unpack(ext_params))
					Duel.CastFree(sg)
				else
					Duel.CastFree(g)
				end
			end
end
--Clash
--target for abilities that let a player clash with their opponent
function Auxiliary.ClashTarget(p)
	--p: the player who initiates the clash (PLAYER_SELF or PLAYER_OPPO)
	return	function(e,tp,eg,ep,ev,re,r,rp,chk)
				local player=(p==PLAYER_SELF and tp) or (p==PLAYER_OPPO and 1-tp)
				if chk==0 then return Duel.IsPlayerCanClash(player) end
			end
end
--Shield Peek, Peeping
--operation for abilities that let a player look at cards that are not public knowledge
function Auxiliary.ConfirmOperation(p,f,s,o,min,max,ex,...)
	--f: include Card.IsFacedown for LOCATION_SZONE, not Card.IsPublic for LOCATION_HAND
	--p,min,max: nil to look at all cards
	local ext_params={...}
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local player=(p==PLAYER_SELF and tp) or (p==PLAYER_OPPO and 1-tp)
				max=max or min
				local g=Duel.GetMatchingGroup(f,tp,s,o,ex,table.unpack(ext_params))
				if g:GetCount()==0 then return end
				if e:IsHasType(EFFECT_TYPE_CONTINUOUS) then Duel.Hint(HINT_CARD,0,e:GetHandler():GetOriginalCode()) end
				if min and max then
					Duel.Hint(HINT_SELECTMSG,player,HINTMSG_CONFIRM)
					local sg=g:Select(player,min,max,ex,table.unpack(ext_params))
					local hg=sg:Filter(Card.IsLocation,nil,LOCATION_BZONE+LOCATION_SZONE)
					Duel.HintSelection(hg)
					Duel.ConfirmCards(player,sg)
				else
					Duel.ConfirmCards(player,g)
				end
			end
end
--operation for abilities that let a player look at cards from the top of the deck
function Auxiliary.DecktopConfirmOperation(p,ct)
	--p: the player whose cards to look at (PLAYER_SELF, PLAYER_OPPO, or PLAYER_ALL)
	--ct: the number of cards to look at
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local player1=(p==PLAYER_SELF and tp) or (p==PLAYER_OPPO and 1-tp) or (p==PLAYER_ALL and tp)
				local player2=(p==PLAYER_SELF and tp) or (p==PLAYER_OPPO and 1-tp) or (p==PLAYER_ALL and 1-tp)
				if Duel.GetFieldGroupCount(player1,LOCATION_DECK,0)==0
					and Duel.GetFieldGroupCount(player2,LOCATION_DECK,0)==0 then return end
				if e:IsHasType(EFFECT_TYPE_CONTINUOUS) then Duel.Hint(HINT_CARD,0,e:GetHandler():GetOriginalCode()) end
				local g1=Duel.GetDecktopGroup(player1,ct)
				local g2=Duel.GetDecktopGroup(player2,ct)
				if g1:GetCount()>0 then
					Duel.ConfirmCards(player1,g1)
				end
				if g2:GetCount()>0 and p==PLAYER_ALL then
					Duel.ConfirmCards(player2,g2)
				end
			end
end
--Card Discard
--operation for abilities that discard cards
function Auxiliary.DiscardOperation(p,f,s,o,min,max,ram,ex,...)
	--p,min,max: nil to discard all cards
	--ram: true to discard cards at random
	local ext_params={...}
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local player1=(p==PLAYER_SELF and tp) or (p==PLAYER_OPPO and 1-tp) or (p==PLAYER_ALL and tp)
				local player2=(p==PLAYER_SELF and tp) or (p==PLAYER_OPPO and 1-tp) or (p==PLAYER_ALL and 1-tp)
				max=max or min
				local c=e:GetHandler()
				local exg=Group.CreateGroup()
				if c:IsSpell() and c:IsLocation(LOCATION_HAND) and s==LOCATION_HAND then exg:AddCard(c) end
				if type(ex)=="Card" then exg:AddCard(ex)
				elseif type(ex)=="Group" then exg:Merge(ex) end
				local g1=Duel.GetMatchingGroup(f,tp,s,o,exg,table.unpack(ext_params))
				local g2=Duel.GetMatchingGroup(f,1-tp,s,o,exg,table.unpack(ext_params))
				if g1:GetCount()==0 and g2:GetCount()==0 then return end
				if e:IsHasType(EFFECT_TYPE_CONTINUOUS) then Duel.Hint(HINT_CARD,0,c:GetOriginalCode()) end
				local sg1=nil
				local sg2=nil
				if min and max then
					if ram then
						sg1=g1:RandomSelect(player1,min)
						if p==PLAYER_ALL then
							sg2=g2:RandomSelect(player2,min)
							sg1:Merge(sg2)
						end
					else
						Duel.Hint(HINT_SELECTMSG,player1,HINTMSG_DISCARD)
						sg1=g1:Select(player1,min,max,exg,table.unpack(ext_params))
						if p==PLAYER_ALL then
							Duel.Hint(HINT_SELECTMSG,player2,HINTMSG_DISCARD)
							sg2=g2:Select(player2,min,max,exg,table.unpack(ext_params))
							sg1:Merge(sg2)
						end
					end
					Duel.KJSendtoDPile(sg1,REASON_EFFECT+REASON_DISCARD)
				else
					if p==PLAYER_ALL then g1:Merge(g2) end
					Duel.KJSendtoDPile(g1,REASON_EFFECT+REASON_DISCARD)
				end
			end
end
--Card Draw
--target and operation functions for abilities that draw a specified number of cards
function Auxiliary.DrawTarget(p)
	--p: the player who draws the card (PLAYER_SELF, PLAYER_OPPO, or PLAYER_ALL)
	return	function(e,tp,eg,ep,ev,re,r,rp,chk)
				local player1=(p==PLAYER_SELF and tp) or (p==PLAYER_OPPO and 1-tp) or (p==PLAYER_ALL and tp)
				local player2=(p==PLAYER_SELF and tp) or (p==PLAYER_OPPO and 1-tp) or (p==PLAYER_ALL and 1-tp)
				if chk==0 then
					local b1=Duel.IsPlayerCanDraw(player1,1)
					local b2=Duel.IsPlayerCanDraw(player2,1)
					if p==PLAYER_ALL then
						return b1 or b2
					else
						return b1
					end
				end
			end
end
function Auxiliary.DrawOperation(p,ct)
	--ct: the number of cards to draw
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local player1=(p==PLAYER_SELF and tp) or (p==PLAYER_OPPO and 1-tp) or (p==PLAYER_ALL and tp)
				local player2=(p==PLAYER_SELF and tp) or (p==PLAYER_OPPO and 1-tp) or (p==PLAYER_ALL and 1-tp)
				if not Duel.IsPlayerCanDraw(player1,1) and not Duel.IsPlayerCanDraw(player2,1) then return end
				if e:IsHasType(EFFECT_TYPE_CONTINUOUS) then Duel.Hint(HINT_CARD,0,e:GetHandler():GetOriginalCode()) end
				Duel.Draw(player1,ct,REASON_EFFECT)
				if p==PLAYER_ALL then
					Duel.Draw(player2,ct,REASON_EFFECT)
				end
			end
end
--operation for abilities that draw up to a number of cards
--use Auxiliary.DrawTarget for the target function, if needed
function Auxiliary.DrawUpToOperation(p,ct)
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local player=(p==PLAYER_SELF and tp) or (p==PLAYER_OPPO and 1-tp)
				if not Duel.IsPlayerCanDraw(player,1) then return end
				if e:IsHasType(EFFECT_TYPE_CONTINUOUS) then Duel.Hint(HINT_CARD,0,e:GetHandler():GetOriginalCode()) end
				Duel.DrawUpTo(player,ct,REASON_EFFECT)
			end
end
--Put Into Battle Zone
--target and operation functions for abilities that send creatures to the battle zone
function Auxiliary.SendtoBZoneFilter(c,e,tp,f,...)
	return c:IsAbleToBZone(e,0,tp,false,false) and (not f or f(c,e,tp,...))
end
function Auxiliary.SendtoBZoneTarget(f,s,o,ex,...)
	local ext_params={...}
	return	function(e,tp,eg,ep,ev,re,r,rp,chk)
				if chk==0 then
					if s==LOCATION_DECK or o==LOCATION_DECK then
						return Duel.GetFieldGroupCount(tp,s,o)>0
					else
						return Duel.IsExistingMatchingCard(Auxiliary.SendtoBZoneFilter,tp,s,o,1,ex,e,tp,f,table.unpack(ext_params))
					end
				end
			end
end
function Auxiliary.SendtoBZoneOperation(p,f,s,o,min,max,pos,ex,...)
	--p,min,max: nil to send all cards to the battle zone
	--pos: POS_FACEUP_UNTAPPED for untapped position or POS_FACEUP_TAPPED for tapped position
	local ext_params={...}
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local player=(p==PLAYER_SELF and tp) or (p==PLAYER_OPPO and 1-tp)
				max=max or min
				pos=pos or POS_FACEUP_UNTAPPED
				local bzone_count=Duel.GetLocationCount(player,LOCATION_BZONE)
				if max>bzone_count then max=bzone_count end
				local g=Duel.GetMatchingGroup(Auxiliary.SendtoBZoneFilter,tp,s,o,ex,e,tp,f,table.unpack(ext_params))
				if g:GetCount()==0 then return end
				if e:IsHasType(EFFECT_TYPE_CONTINUOUS) then Duel.Hint(HINT_CARD,0,e:GetHandler():GetOriginalCode()) end
				if min and max then
					Duel.Hint(HINT_SELECTMSG,player,HINTMSG_TOBZONE)
					local sg=g:Select(player,min,max,ex,table.unpack(ext_params))
					for sc in aux.Next(sg) do
						Duel.SendtoBZone(sc,0,player,sc:GetOwner(),false,false,pos)
					end
				else
					for tc in aux.Next(g) do
						Duel.SendtoBZone(tc,0,player,tc:GetOwner(),false,false,pos)
					end
				end
			end
end
--operation for abilities that send cards from the top of a player's deck to the battle zone
--use Auxiliary.CheckDeckFunction for the target function, if needed
function Auxiliary.DecktopSendtoBZoneOperation(p,f,ct,min,max,seq,conf_deck,pos,ex,...)
	--p: the player whose cards to look at (PLAYER_SELF or PLAYER_OPPO)
	--ct: the number of cards to look at
	--min,max: nil if the player does not select cards or if ct is 1
	--seq: where to send the remaining cards (SEQ_DECK)
	--conf_deck: true to reveal the top cards of the deck
	local ext_params={...}
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local player=(p==PLAYER_SELF and tp) or (p==PLAYER_OPPO and 1-tp)
				max=max or min
				pos=pos or POS_FACEUP_UNTAPPED
				if Duel.GetFieldGroupCount(player,LOCATION_DECK,0)==0 then return end
				if e:IsHasType(EFFECT_TYPE_CONTINUOUS) then Duel.Hint(HINT_CARD,0,e:GetHandler():GetOriginalCode()) end
				local g=Duel.GetDecktopGroup(player,ct)
				if conf_deck then
					Duel.ConfirmDecktop(player,1)
				else
					Duel.ConfirmCards(player,g)
				end
				local bzone_count=Duel.GetLocationCount(player,LOCATION_BZONE)
				if max>bzone_count then max=bzone_count end
				if g:IsExists(Auxiliary.SendtoBZoneFilter,1,ex,e,tp,f,table.unpack(ext_params)) then
					if ct==1 then
						Duel.DisableShuffleCheck()
						Duel.SendtoBZone(g:GetFirst(),0,player,g:GetFirst():GetOwner(),false,false,pos)
					elseif min and max and ct>1 then
						Duel.Hint(HINT_SELECTMSG,player,HINTMSG_TOBZONE)
						local sg=g:FilterSelect(player,Auxiliary.SendtoBZoneFilter,min,max,ex,e,tp,f,table.unpack(ext_params))
						Duel.DisableShuffleCheck()
						for sc in aux.Next(sg) do
							Duel.SendtoBZone(sc,0,player,sc:GetOwner(),false,false,pos)
						end
						Auxiliary.SortDeck(player,player,ct-sg:GetCount(),seq)
					end
				else Auxiliary.SortDeck(player,player,ct,seq) end
			end
end
--Deck Feed
--operation for abilities that send cards to the deck
function Auxiliary.SendtoDeckOperation(p,f,s,o,min,max,seq,ex,...)
	--p,min,max: nil to send all cards to the deck
	--seq: where to send the cards (SEQ_DECK)
	local ext_params={...}
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local player=(p==PLAYER_SELF and tp) or (p==PLAYER_OPPO and 1-tp)
				max=max or min
				local c=e:GetHandler()
				local exg=Group.CreateGroup()
				if c:IsSpell() and c:IsLocation(LOCATION_HAND) and s==LOCATION_HAND then exg:AddCard(c) end
				if type(ex)=="Card" then exg:AddCard(ex)
				elseif type(ex)=="Group" then exg:Merge(ex) end
				local g=Duel.GetMatchingGroup(aux.AND(Card.IsAbleToDeck,f),tp,s,o,exg,table.unpack(ext_params))
				if g:GetCount()==0 then return end
				if e:IsHasType(EFFECT_TYPE_CONTINUOUS) then Duel.Hint(HINT_CARD,0,c:GetOriginalCode()) end
				if min and max then
					Duel.Hint(HINT_SELECTMSG,player,HINTMSG_TODECK)
					local sg=g:Select(player,min,max,exg,table.unpack(ext_params))
					local hg=sg:Filter(Card.IsLocation,nil,LOCATION_BZONE+LOCATION_SZONE)
					Duel.HintSelection(hg)
					Duel.SendtoDeck(sg,PLAYER_OWNER,seq,REASON_EFFECT)
				else
					Duel.SendtoDeck(g,PLAYER_OWNER,seq,REASON_EFFECT)
				end
			end
end
--Discard Pile Feed
--target and operation functions for abilities that send cards from the top of a player's deck to the discard pile
function Auxiliary.DecktopKJSendtoDPileTarget(p)
	--p: the player whose cards to send to the discard pile (PLAYER_SELF or PLAYER_OPPO)
	return	function(e,tp,eg,ep,ev,re,r,rp,chk)
				local player=(p==PLAYER_SELF and tp) or (p==PLAYER_OPPO and 1-tp)
				if chk==0 then return Duel.KJIsPlayerCanSendDecktoptoDPile(player,1) end
			end
end
function Auxiliary.DecktopKJSendtoDPileOperation(p,ct)
	--ct: the number of cards to send to the discard pile
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local player=(p==PLAYER_SELF and tp) or (p==PLAYER_OPPO and 1-tp)
				if not Duel.KJIsPlayerCanSendDecktoptoDPile(player,1) then return end
				if e:IsHasType(EFFECT_TYPE_CONTINUOUS) then Duel.Hint(HINT_CARD,0,e:GetHandler():GetOriginalCode()) end
				Duel.KJSendDecktoptoDPile(player,ct,REASON_EFFECT)
			end
end
--Put Into Hand
--operation for abilities that send cards to the hand
function Auxiliary.SendtoHandOperation(p,f,s,o,min,max,conf,ex,...)
	--p,min,max: nil to send all cards to the hand
	--conf: true to reveal cards added from the deck
	local ext_params={...}
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local player=(p==PLAYER_SELF and tp) or (p==PLAYER_OPPO and 1-tp)
				max=max or min
				local desc=HINTMSG_RTOHAND
				local g=Duel.GetMatchingGroup(aux.AND(Card.IsAbleToHand,f),tp,s,o,ex,table.unpack(ext_params))
				if g:GetCount()==0 then return end
				if e:IsHasType(EFFECT_TYPE_CONTINUOUS) then Duel.Hint(HINT_CARD,0,e:GetHandler():GetOriginalCode()) end
				if min and max then
					if s==LOCATION_DECK or o==LOCATION_DECK then desc=HINTMSG_ATOHAND end
					Duel.Hint(HINT_SELECTMSG,player,desc)
					local sg=g:Select(player,min,max,ex,table.unpack(ext_params))
					local hg=sg:Filter(Card.IsLocation,nil,LOCATION_BZONE+LOCATION_SZONE)
					Duel.HintSelection(hg)
					Duel.SendtoHand(sg,PLAYER_OWNER,REASON_EFFECT)
				else
					Duel.SendtoHand(g,PLAYER_OWNER,REASON_EFFECT)
				end
				local cffilter=function(c,p,loc)
					return c:IsControler(p) and c:IsPreviousLocation(loc)
				end
				local og1=Duel.GetOperatedGroup():Filter(cffilter,nil,tp,LOCATION_DECK)
				local og2=Duel.GetOperatedGroup():Filter(cffilter,nil,1-tp,LOCATION_DECK)
				local og3=Duel.GetOperatedGroup():Filter(cffilter,nil,tp,LOCATION_MZONEUNT+LOCATION_DPILE)
				local og4=Duel.GetOperatedGroup():Filter(cffilter,nil,1-tp,LOCATION_MZONEUNT+LOCATION_DPILE)
				--show cards taken from the deck only if the ability says to do so
				if conf and og1:GetCount()>0 then Duel.ConfirmCards(1-tp,og1) end
				if conf and og2:GetCount()>0 then Duel.ConfirmCards(tp,og2) end
				--show cards taken from the mana zone or discard pile by default
				if og3:GetCount()>0 then Duel.ConfirmCards(1-tp,og3) end
				if og4:GetCount()>0 then Duel.ConfirmCards(tp,og4) end
			end
end
--operation for abilities that target cards to send to the hand
function Auxiliary.TargetSendtoHandOperation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	if g:GetCount()==0 or Duel.SendtoHand(g,PLAYER_OWNER,REASON_EFFECT)==0 then return end
	local cffilter=function(c,p,loc)
		return c:IsControler(p) and c:IsPreviousLocation(loc)
	end
	local og1=Duel.GetOperatedGroup():Filter(cffilter,nil,tp,LOCATION_MZONEUNT+LOCATION_DPILE)
	local og2=Duel.GetOperatedGroup():Filter(cffilter,nil,1-tp,LOCATION_MZONEUNT+LOCATION_DPILE)
	--show cards taken from the mana zone or discard pile by default
	if og1:GetCount()>0 then Duel.ConfirmCards(1-tp,og1) end
	if og2:GetCount()>0 then Duel.ConfirmCards(tp,og2) end
end
--operation for abilities that send cards from the top of a player's deck to the hand
function Auxiliary.DecktopSendtoHandOperation(p,f,ct,min,max,seq,conf_deck,conf_add,ex,...)
	--p: the player whose cards to look at (PLAYER_SELF or PLAYER_OPPO)
	--ct: the number of cards to look at
	--min,max: nil if the player does not select cards or if ct is 1
	--seq: where to send the remaining cards (SEQ_DECK)
	--conf_deck: true to reveal the top cards of the deck
	--conf_add: true to reveal cards added from the deck
	local ext_params={...}
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local player=(p==PLAYER_SELF and tp) or (p==PLAYER_OPPO and 1-tp)
				max=max or min
				if Duel.GetFieldGroupCount(player,LOCATION_DECK,0)==0 then return end
				if e:IsHasType(EFFECT_TYPE_CONTINUOUS) then Duel.Hint(HINT_CARD,0,e:GetHandler():GetOriginalCode()) end
				local g=Duel.GetDecktopGroup(player,ct)
				if conf_deck then
					Duel.ConfirmDecktop(player,1)
				else
					Duel.ConfirmCards(player,g)
				end
				if g:IsExists(aux.AND(Card.IsAbleToHand,f),1,ex,table.unpack(ext_params)) then
					if ct==1 then
						Duel.DisableShuffleCheck()
						if Duel.SendtoHand(g:GetFirst(),PLAYER_OWNER,REASON_EFFECT)>0 then
							if conf_add then Duel.ConfirmCards(1-player,g:GetFirst()) end
							Duel.ShuffleHand(player)
						end
					elseif min and max and ct>1 then
						Duel.Hint(HINT_SELECTMSG,player,HINTMSG_ATOHAND)
						local sg=g:FilterSelect(player,aux.AND(Card.IsAbleToHand,f),min,max,ex,table.unpack(ext_params))
						Duel.DisableShuffleCheck()
						if Duel.SendtoHand(sg,PLAYER_OWNER,REASON_EFFECT)>0 then
							if conf_add then Duel.ConfirmCards(1-player,sg) end
							Duel.ShuffleHand(player)
						end
						Auxiliary.SortDeck(player,player,ct-sg:GetCount(),seq)
					end
				else Auxiliary.SortDeck(player,player,ct,seq) end
			end
end
--Mana Feed
--operation for abilities that send cards to the mana zone (untapped)
function Auxiliary.SendtoMZoneOperation(p,f,s,o,min,max,ex,...)
	--p,min,max: nil to send all cards to the mana zone
	local ext_params={...}
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local player=(p==PLAYER_SELF and tp) or (p==PLAYER_OPPO and 1-tp)
				max=max or min
				local c=e:GetHandler()
				local exg=Group.CreateGroup()
				if c:IsSpell() and c:IsLocation(LOCATION_HAND) and s==LOCATION_HAND then exg:AddCard(c) end
				if type(ex)=="Card" then exg:AddCard(ex)
				elseif type(ex)=="Group" then exg:Merge(ex) end
				local g=Duel.GetMatchingGroup(aux.AND(Card.IsAbleToMZone,f),tp,s,o,exg,table.unpack(ext_params))
				if g:GetCount()==0 then return end
				if e:IsHasType(EFFECT_TYPE_CONTINUOUS) then Duel.Hint(HINT_CARD,0,c:GetOriginalCode()) end
				if min and max then
					Duel.Hint(HINT_SELECTMSG,player,HINTMSG_TOMZONE)
					local sg=g:Select(player,min,max,exg,table.unpack(ext_params))
					local hg=sg:Filter(Card.IsLocation,nil,LOCATION_BZONE+LOCATION_SZONE)
					Duel.HintSelection(hg)
					Duel.SendtoMZone(sg,POS_FACEUP_UNTAPPED,REASON_EFFECT)
				else
					Duel.SendtoMZone(g,POS_FACEUP_UNTAPPED,REASON_EFFECT)
				end
			end
end
--target and operation functions for abilities that send cards from the top of a player's deck to the mana zone (untapped)
function Auxiliary.DecktopSendtoMZoneTarget(p)
	--p: the player whose cards to send to the mana zone (PLAYER_SELF or PLAYER_OPPO)
	return	function(e,tp,eg,ep,ev,re,r,rp,chk)
				local player=(p==PLAYER_SELF and tp) or (p==PLAYER_OPPO and 1-tp)
				if chk==0 then return Duel.IsPlayerCanSendDecktoptoMZone(player,1) end
			end
end
function Auxiliary.DecktopSendtoMZoneOperation(p,ct)
	--ct: the number of cards to send to the mana zone
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local player=(p==PLAYER_SELF and tp) or (p==PLAYER_OPPO and 1-tp)
				if not Duel.IsPlayerCanSendDecktoptoMZone(player,1) then return end
				if e:IsHasType(EFFECT_TYPE_CONTINUOUS) then Duel.Hint(HINT_CARD,0,e:GetHandler():GetOriginalCode()) end
				Duel.SendDecktoptoMZone(player,ct,POS_FACEUP_UNTAPPED,REASON_EFFECT)
			end
end
--Shield Feed
--target and operation functions for abilities that send cards from the top of a player's deck to the shield zone
function Auxiliary.DecktopSendtoSZoneTarget(p)
	--p: the player whose cards to send to the shield zone (PLAYER_SELF or PLAYER_OPPO)
	return	function(e,tp,eg,ep,ev,re,r,rp,chk)
				local player=(p==PLAYER_SELF and tp) or (p==PLAYER_OPPO and 1-tp)
				if chk==0 then return Duel.IsPlayerCanSendDecktoptoSZone(player,1) end
			end
end
function Auxiliary.DecktopSendtoSZoneOperation(p,ct)
	--ct: the number of cards to send to the shield zone
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local player=(p==PLAYER_SELF and tp) or (p==PLAYER_OPPO and 1-tp)
				if not Duel.IsPlayerCanSendDecktoptoSZone(player,1) then return end
				if e:IsHasType(EFFECT_TYPE_CONTINUOUS) then Duel.Hint(HINT_CARD,0,e:GetHandler():GetOriginalCode()) end
				Duel.SendDecktoptoSZone(player,ct)
			end
end
--Sort
--operation for abilities that let a player look at the top cards of a player's deck and return them in any order
--use Auxiliary.CheckDeckFunction for the target function, if needed
function Auxiliary.SortDecktopOperation(sortp,tgp,ct)
	--sortp: the player who sorts the cards (PLAYER_SELF or PLAYER_OPPO)
	--tgp: the player whose deck to sort the cards from (PLAYER_SELF or PLAYER_OPPO)
	--ct: the number of cards to sort
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local sort_player=(sortp==PLAYER_SELF and tp) or (sortp==PLAYER_OPPO and 1-tp)
				local target_player=(tgp==PLAYER_SELF and tp) or (tgp==PLAYER_OPPO and 1-tp)
				if Duel.GetFieldGroupCount(target_player,LOCATION_DECK,0)==0 then return end
				if e:IsHasType(EFFECT_TYPE_CONTINUOUS) then Duel.Hint(HINT_CARD,0,e:GetHandler():GetOriginalCode()) end
				local g=Duel.GetDecktopGroup(target_player,ct)
				Duel.SortDecktop(sort_player,target_player,ct)
			end
end
--Tap, Untap
--operation for abilities that tap cards
function Auxiliary.TapOperation(p,f,s,o,min,max,ex,...)
	--p,min,max: nil to tap all cards
	local ext_params={...}
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local player=(p==PLAYER_SELF and tp) or (p==PLAYER_OPPO and 1-tp)
				max=max or min
				local g=Duel.GetMatchingGroup(aux.AND(Card.IsAbleToTap,f),tp,s,o,ex,table.unpack(ext_params))
				if g:GetCount()==0 then return end
				if e:IsHasType(EFFECT_TYPE_CONTINUOUS) then Duel.Hint(HINT_CARD,0,e:GetHandler():GetOriginalCode()) end
				local tc=Duel.GetAttacker()
				if tc and tc:IsAbleToTap() then Duel.Tap(tc,REASON_RULE) end --fix creature not being tapped when attacking
				if min and max then
					Duel.Hint(HINT_SELECTMSG,player,HINTMSG_TAP)
					local sg=g:Select(player,min,max,ex,table.unpack(ext_params))
					local hg=sg:Filter(Card.IsLocation,nil,LOCATION_BZONE)
					Duel.HintSelection(hg)
					Duel.Tap(sg,REASON_EFFECT)
				else
					Duel.Tap(g,REASON_EFFECT)
				end
			end
end
--operation for abilities that untap cards
function Auxiliary.UntapOperation(p,f,s,o,min,max,ex,...)
	--p,min,max: nil to untap all cards
	local ext_params={...}
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local player=(p==PLAYER_SELF and tp) or (p==PLAYER_OPPO and 1-tp)
				local g=Duel.GetMatchingGroup(aux.AND(Card.IsAbleToUntap,f),tp,s,o,ex,table.unpack(ext_params))
				if g:GetCount()==0 then return end
				if e:IsHasType(EFFECT_TYPE_CONTINUOUS) then Duel.Hint(HINT_CARD,0,e:GetHandler():GetOriginalCode()) end
				local tc=Duel.GetAttacker()
				if tc and tc:IsAbleToTap() then Duel.Tap(tc,REASON_RULE) end --fix creature not being tapped when attacking
				if min and max then
					Duel.Hint(HINT_SELECTMSG,player,HINTMSG_UNTAP)
					local sg=g:Select(player,min,max,ex,table.unpack(ext_params))
					local hg=sg:Filter(Card.IsLocation,nil,LOCATION_BZONE)
					Duel.HintSelection(hg)
					Duel.Untap(sg,REASON_EFFECT)
				else
					Duel.Untap(g,REASON_EFFECT)
				end
			end
end
--Increase Power, Decrease Power
--operation for abilities that target creatures to increase/reduce their power
function Auxiliary.TargetUpdatePowerOperation(desc_id,val,reset_flag,reset_count)
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
				if g:GetCount()==0 then return end
				reset_flag=reset_flag or RESET_PHASE+PHASE_END
				reset_count=reset_count or 1
				for tc in aux.Next(g) do
					Auxiliary.AddTempEffectUpdatePower(e:GetHandler(),tc,desc_id,val,reset_flag,reset_count)
				end
			end
end

--condition to check who the turn player is
function Auxiliary.TurnPlayerCondition(p)
	return	function(e)
				local tp=e:GetHandlerPlayer()
				local player=(p==PLAYER_SELF and tp) or (p==PLAYER_OPPO and 1-tp)
				return Duel.GetTurnPlayer()==player
			end
end
--condition to check who the event player is
function Auxiliary.EventPlayerCondition(p)
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local player=(p==PLAYER_SELF and tp) or (p==PLAYER_OPPO and 1-tp)
				return ep==player
			end
end
--condition to check if a player has a particular card in a location
--e.g. "Cliffcutter" (4EVO 36/55)
function Auxiliary.ExistingCardCondition(f,s,o,count)
	return	function(e,tp,eg,ep,ev,re,r,rp)
				f=f or aux.TRUE
				s=s or LOCATION_BZONE
				o=o or 0
				count=count or 1
				return Duel.IsExistingMatchingCard(f,e:GetHandlerPlayer(),s,o,count,nil)
			end
end
--condition of "While this creature is attacking"
--e.g. "Flametropus" (1TVR 26/43)
function Auxiliary.SelfAttackerCondition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker()==e:GetHandler()
end
--condition of "While this creature is being attacked"
--e.g. "Quillspike Tatsurion" (2DED D1/D1)
function Auxiliary.SelfAttackTargetCondition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttackTarget()==e:GetHandler()
end
--condition of "While this creature is battling"
--e.g. "Flamespike Tatsurion" (4EVO S5/S5), "Ironvine Dragon" (7CLA 59/110)
function Auxiliary.SelfBattlingCondition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return (Duel.GetAttacker()==c or Duel.GetAttackTarget()==c) and c:IsRelateToBattle()
end
--condition of "While this creature is blocking"
--e.g. "Steadfast Vorwhal" (13GAU 52/160)
function Auxiliary.SelfBlockCondition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetBlocker()==e:GetHandler()
end
--condition of "Whenever this creature wins a battle" + EVENT_BATTLE_BANISHING
--e.g. "Trox, General of Destruction" (2DED 32/55)
function Auxiliary.SelfBattleWinCondition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsRelateToBattle() and c:IsLocation(LOCATION_BZONE)
end
--condition of "Whenever one of your creatures wins a battle" + EVENT_BATTLE_BANISHING
--e.g. "Lepidos the Ancient" (4EVO 49/55)
function Auxiliary.BattleWinCondition(f)
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local ec=eg:GetFirst()
				return ec:IsRelateToBattle() and ec:IsControler(tp) and (not f or f(ec))
			end
end
--condition to check if "this creature" has left the battle zone
--e.g. "Ghost Spy" (2DED 26/55), "Anjak, the All-Kin" (13GAU 123/160)
function Auxiliary.SelfLeaveBZoneCondition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_BZONE)
end
--condition to check if a player's creature has left the battle zone
--e.g. "Black Feather of Shadow Abyss" (2DED 24/55), "Volcano Trooper" (13GAU 118/160)
function Auxiliary.LeaveBZoneCondition(p)
	--p: the player whose creature has left the battle zone (PLAYER_SELF, PLAYER_OPPO, or nil for either player)
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local player=(p==PLAYER_SELF and tp) or (p==PLAYER_OPPO and 1-tp)
				if not eg:IsExists(Card.IsCreature,1,nil) then return false end
				if player then
					return eg:IsExists(aux.FilterEqualFunction(Card.GetPreviousControler,player),1,nil)
				else return true end
			end
end
--condition of "While all cards in your mana zone are CIVILIZATION cards"
--e.g. "Prism-Blade Enforcer" (4EVO 7/55)
function Auxiliary.MZoneExclusiveCondition(f,...)
	local ext_params={...}
	return	function(e)
				local tp=e:GetHandlerPlayer()
				local filt_func=function(c,f,...)
					return not f(c,...)
				end
				return Duel.IsExistingMatchingCard(Auxiliary.ManaZoneFilter(),tp,LOCATION_MZONE,0,1,nil,f,table.unpack(ext_params))
					and not Duel.IsExistingMatchingCard(Auxiliary.ManaZoneFilter(filt_func),tp,LOCATION_MZONE,0,1,nil,f,table.unpack(ext_params))
			end
end
--condition of "While you have only X creatures in the battle zone"
--e.g. "Enslaved Flametropus" (P14/Y2PRM)
function Auxiliary.BZoneExclusiveCondition(f,...)
	local ext_params={...}
	return	function(e)
				local tp=e:GetHandlerPlayer()
				local filt_func=function(c,f,...)
					return not f(c,...)
				end
				return not Duel.IsExistingMatchingCard(filt_func,tp,LOCATION_BZONE,0,1,nil,f,table.unpack(ext_params))
			end
end
--condition for a player having no cards in their hand
--e.g. "Ragefire Tatsurion" (6DSI 43/55)
function Auxiliary.NoHandCondition(p)
	return	function(e)
				local tp=e:GetHandlerPlayer()
				local player=(p==PLAYER_SELF and tp) or (p==PLAYER_OPPO and 1-tp)
				return Duel.GetFieldGroupCount(player,LOCATION_HAND,0)==0
			end
end
--condition for a player having no shields
--e.g. "Timelost Phantom" (15VTX 87/160)
function Auxiliary.NoShieldsCondition(p)
	return	function(e)
				local tp=e:GetHandlerPlayer()
				local player=(p==PLAYER_SELF and tp) or (p==PLAYER_OPPO and 1-tp)
				return Duel.GetShieldCount(player)==0
			end
end
--condition of "While this creature is tapped"
--e.g. "Issyl of the Frozen Wastes" (6DSI S2/S5)
function Auxiliary.SelfTappedCondition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsTapped()
end
--condition of "When a card enters the zone" (untapped) + EVENT_TO_MZONE
--e.g. "Kurragar of the Hordes" (6DSI S5/S5)
function Auxiliary.EnterMZoneUntappedCondition(p)
	--p: the player whose cards enter the mana zone (PLAYER_SELF, PLAYER_OPPO, or nil for either player)
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local player=(p==PLAYER_SELF and tp) or (p==PLAYER_OPPO and 1-tp)
				local f=function(c,player)
					if not c:IsUntapped() then return false end
					if player then
						return c:IsControler(player)
					else return true end
				end
				return eg:IsExists(f,1,nil,player)
			end
end
--condition of "When a card enters the mana zone" (tapped) + EVENT_TO_MZONE_TAPPED
--e.g. "Kurragar of the Hordes" (6DSI S5/S5)
function Auxiliary.EnterMZoneTappedCondition(p)
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local player=(p==PLAYER_SELF and tp) or (p==PLAYER_OPPO and 1-tp)
				local f=function(c,player)
					if not c:IsTapped() or c:IsPreviousLocation(LOCATION_MZONEUNT) then return false end
					if player then
						return c:IsControler(player)
					else return true end
				end
				return eg:IsExists(f,1,nil,player)
			end
end
--condition to check if a creature is attacking a player
--e.g. "Death Liger, Apex Predator" (7CLA S3/S10)
function Auxiliary.AttackPlayerCondition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttackTarget()==nil
end
--condition to check if the attacking creature isn't blocked + EVENT_BATTLE_CONFIRM
--e.g. "Death Liger, Apex Predator" (7CLA S3/S10)
function Auxiliary.UnblockedCondition(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttacker()
	return tc and not tc:IsBlocked()
end
--condition of "Whenever this creature becomes the target of one of your opponent's spells or abilities" + EVENT_CHAINING
--e.g. "Infernus the Immolator" (7CLA S4/S10)
function Auxiliary.SelfBecomeTargetCondition(e,tp,eg,ep,ev,re,r,rp)
	if rp==tp or not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then return false end
	local g=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	return g and g:IsContains(e:GetHandler())
end
--condition of "Whenever a player discards a card" + EVENT_DISCARD
--e.g. "Curse-Eye Black Feather" (9SHA 19/80), "Zombie Backhoe" (13GAU 158/160)
function Auxiliary.DiscardHandCondition(p)
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local player=(p==PLAYER_SELF and tp) or (p==PLAYER_OPPO and 1-tp)
				return eg:IsExists(aux.FilterEqualFunction(Card.GetPreviousControler,player),1,nil)
			end
end
--target for a continuous effect that is active to cards other than the card with the continuous effect
function Auxiliary.TargetBoolFunctionExceptSelf(f,...)
	local ext_params={...}
	return	function(effect,target)
				return target~=effect:GetHandler() and (not f or f(target,table.unpack(ext_params)))
			end
end
--target for optional trigger abilities that do not target cards
function Auxiliary.CheckCardFunction(f,s,o,ex,...)
	local ext_params={...}
	return	function(e,tp,eg,ep,ev,re,r,rp,chk)
				local c=e:GetHandler()
				local exg=Group.CreateGroup()
				if c:IsSpell() and c:IsLocation(LOCATION_HAND) and s==LOCATION_HAND then exg:AddCard(c) end
				if type(ex)=="Card" then exg:AddCard(ex)
				elseif type(ex)=="Group" then exg:Merge(ex) end
				if chk==0 then return Duel.IsExistingMatchingCard(f,tp,s,o,1,exg,table.unpack(ext_params)) end
			end
end
--target for trigger abilities that target cards
function Auxiliary.TargetCardFunction(p,f,s,o,min,max,desc,ex,...)
	local ext_params={...}
	return	function(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
				local player=(p==PLAYER_SELF and tp) or (p==PLAYER_OPPO and 1-tp)
				max=max or min
				desc=desc or HINTMSG_TARGET
				local c=e:GetHandler()
				local exg=Group.CreateGroup()
				if c:IsSpell() and c:IsLocation(LOCATION_HAND) and s==LOCATION_HAND then exg:AddCard(c) end
				if type(ex)=="Card" then exg:AddCard(ex)
				elseif type(ex)=="Group" then exg:Merge(ex)
				elseif type(ex)=="function" then
					exg=ex(e,tp,eg,ep,ev,re,r,rp)
				end
				if chkc then
					if min>1 then return false end
					if not chkc:IsLocation(s+o) then return false end
					if s==0 and o>0 and chkc:IsControler(tp) then return false end
					if o==0 and s>0 and chkc:IsControler(1-tp) then return false end
					if f and not f(chkc,e,tp,eg,ep,ev,re,r,rp) then return false end
					if exg:GetCount()>0 and exg:IsContains(chkc) then return false end
					return true
				end
				if chk==0 then
					if e:IsHasType(EFFECT_TYPE_TRIGGER_F) or e:IsHasType(EFFECT_TYPE_QUICK_F) or c:IsSpell() then return true end
					return Duel.IsExistingTarget(f,tp,s,o,1,exg,table.unpack(ext_params))
				end
				Duel.Hint(HINT_SELECTMSG,player,desc)
				Duel.SelectTarget(player,f,tp,s,o,min,max,exg,table.unpack(ext_params))
			end
end
--target for trigger abilities that target cards and displays the triggered ability
function Auxiliary.TargetCardFunction2(p,f,s,o,min,max,desc,ex,...)
	local ext_params={...}
	return	function(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
				local player=(p==PLAYER_SELF and tp) or (p==PLAYER_OPPO and 1-tp)
				max=max or min
				desc=desc or HINTMSG_TARGET
				local c=e:GetHandler()
				local exg=Group.CreateGroup()
				if c:IsSpell() and c:IsLocation(LOCATION_HAND) and s==LOCATION_HAND then exg:AddCard(c) end
				if type(ex)=="Card" then exg:AddCard(ex)
				elseif type(ex)=="Group" then exg:Merge(ex)
				elseif type(ex)=="function" then
					exg=ex(e,tp,eg,ep,ev,re,r,rp)
				end
				if chkc then
					if min>1 then return false end
					if not chkc:IsLocation(s+o) then return false end
					if s==0 and o>0 and chkc:IsControler(tp) then return false end
					if o==0 and s>0 and chkc:IsControler(1-tp) then return false end
					if f and not f(chkc,e,tp,eg,ep,ev,re,r,rp) then return false end
					if exg:GetCount()>0 and exg:IsContains(chkc) then return false end
					return true
				end
				if chk==0 then
					if e:IsHasType(EFFECT_TYPE_TRIGGER_F) or e:IsHasType(EFFECT_TYPE_QUICK_F) or c:IsSpell() then return true end
					return Duel.IsExistingTarget(f,tp,s,o,1,exg,table.unpack(ext_params))
				end
				Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
				Duel.Hint(HINT_SELECTMSG,player,desc)
				Duel.SelectTarget(player,f,tp,s,o,min,max,exg,table.unpack(ext_params))
			end
end
--target to check if a player has cards in their deck
function Auxiliary.CheckDeckFunction(p)
	return	function(e,tp,eg,ep,ev,re,r,rp,chk)
				local player=(p==PLAYER_SELF and tp) or (p==PLAYER_OPPO and 1-tp)
				if chk==0 then return Duel.GetFieldGroupCount(player,LOCATION_DECK,0)>0 end
			end
end
--target for Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
function Auxiliary.HintTarget(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if e:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then
		if chkc then return false end
	end
	if chk==0 then return true end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
end
--filter for a face up creature in the battle zone
--reserved
--[[
function Auxiliary.FaceupFilter(f,...)
	local ext_params={...}
	return	function(target)
				return target:IsFaceup() and f(target,table.unpack(ext_params))
			end
end
]]
--filter for a card in the mana zone
function Auxiliary.ManaZoneFilter(f)
	return	function(target,...)
				return target:IsMana() and (not f or f(target,...))
			end
end
--filter for a card in the discard pile
function Auxiliary.KJDPileFilter(f)
	return	function(target,...)
				return target:IsDPile() and (not f or f(target,...))
			end
end
--filter for a card in the shield zone
function Auxiliary.ShieldZoneFilter(f)
	return	function(target,...)
				return target:IsShield() and (not f or f(target,...))
			end
end
--flag effect for spell casting
function Auxiliary.chainreg(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():GetFlagEffect(1)==0 then
		e:GetHandler():RegisterFlagEffect(1,RESET_EVENT+RESETS_STANDARD-RESET_TURN_SET+RESET_CHAIN,0,1)
	end
end
--filter for EFFECT_CANNOT_BE_EFFECT_TARGET + opponent
function Auxiliary.tgoval(e,re,rp)
	return rp==1-e:GetHandlerPlayer()
end
--
function loadutility(file)
	local f=loadfile("expansions/script/"..file)
	if f==nil then
		dofile("script/"..file)
	else
		f()
	end
end
loadutility("bit.lua")
loadutility("card.lua")
loadutility("duel.lua")
loadutility("group.lua")
loadutility("lua.lua")
loadutility("rule.lua")
--[[
	References
	1. Cost Reduction and Cost Increase abilities don't increase or decrease the cost written on the card
	https://kaijudo.fandom.com/wiki/Citadel_Judge/Rulings
	2. Prevent multiple "shield blast" abilities from chaining
	* Voltanis the Adjudicator
	https://github.com/Fluorohydride/ygopro-scripts/blob/967a2fe/c20951752.lua#L12
	3. Auxiliary.DecktopSendtoHandOperation
	* Dark Magical Circle
	https://github.com/Fluorohydride/ygopro-scripts/blob/cb54f7a/c47222536.lua#L38
	* Ma'at
	https://github.com/Fluorohydride/ygopro-scripts/blob/2c4f0ca/c18631392.lua#L71
	* Spellbook Library of the Heliosphere
	https://github.com/Fluorohydride/ygopro-scripts/blob/6324c1c/c20822520.lua#L65
	* World Legacy Survivor
	https://github.com/Fluorohydride/ygopro-scripts/blob/97e53fe/c31706048.lua#L24
	4. Auxiliary.AddSingleTriggerEffect and Auxiliary.AddTriggerEffect Trigger conditions
	https://duelmasters.fandom.com/wiki/List_of_Trigger_Conditions
]]
