Hook.Add("character.applyDamage", "LuaArmor.ApplyDamage", function (characterHealth, attackResult, hitLimb)
    if hitLimb.type ~= LimbType.Torso then return end

    local character = characterHealth.Character
    if character.Inventory == nil then return end
    local armor = character.Inventory.GetItemInLimbSlot(InvSlotType.OuterClothes)

    if armor == nil or armor.Prefab.Identifier ~= "luaarmor" then return end

    local damage = 0

    for aaaaa in attackResult.Afflictions do
        damage = damage + aaaaa.Strength
    end

    armor.Condition = armor.Condition - damage*0.6

    print(armor.Condition)

    if armor.Condition > 0 then
        return true
    else
        Entity.Spawner.AddEntityToRemoveQueue(armor)
    end
end)

Hook.Add("chatMessage", "examples.giveAfflictions", function (message, client)
    if message ~= "!xibao" then return end
    local burnPrefab = AfflictionPrefab.Prefabs["alcellruin"]
    local character
    if SERVER then
        character = client.Character
    else
        character = Character.Controlled
    end

    if character == nil then return end

    local limb = character.AnimController.GetLimb(LimbType.Torso)

    -- give 50 of burns to the head of the character
    character.CharacterHealth.ApplyAffliction(limb, burnPrefab.Instantiate(50))
end)
