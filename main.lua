local _version = "1.6.66"
local EL01ROXHUB_UI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/download/" .. _version .. "/main.lua"))()

getgenv().ROX_DISCORD = "https://discord.gg/Utb4J4vyng"
getgenv().ROX_HUB = "https://raw.githubusercontent.com/a02548710/XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX/main/main.lua"

local validKeys = {
    ["FREE_63cea7c46926aa7437725417bd51fb40"] = true,
    ["FREE_b95cb80aae9fbbfedded2b63f8242648"] = true,
    ["FREE_6138bd1989413beb6bc7e2d031731d55"] = true,
    ["FREE_935ce19b19d3defe7d6b8d74fc1e4798"] = true,
    ["FREE_bbbc8cec086870b77ea207220a49698b"] = true,
    ["FREE_687b10f66d742b75a2024ed20496ed6a"] = true,
    ["FREE_8ee99bc2ef603cf3d466ceac3cf6a25b"] = true,
    ["FREE_19cd845bbbb3ddaf96b86d008ad83c82"] = true,
    ["FREE_657a8d4029b7ea5ff7830d093bd61204"] = true,
    ["FREE_070a011b564f002d14b9f5f636a7a0e5"] = true,
    ["FREE_743155aeff08ba5fc23ba3292e23f638"] = true,
    ["FREE_07f6170ab8816ed926bf9f83b010fdb4"] = true,
    ["FREE_4fa68822ff23757073a073573d2fd828"] = true,
    ["FREE_c1fd1152fc83030d4f37f7620f0fba25"] = true,
    ["FREE_65dd55c257aa14d0bef04bcf232f0f0b"] = true,
    ["FREE_bdcd452b847c0d4e2b03ec4f60f2f189"] = true,
    ["FREE_e5927d71fe561ea9190708a5f6c96921"] = true,
    ["FREE_87cb9683c307fdfdb26eb11f6e5289ed"] = true,
    ["FREE_c59950395e5ab4074bbb4635cf3de267"] = true,
    ["FREE_3fc1b9d207e2b969494d6e8b40990e1f"] = true,
    ["FREE_d5f87c40fc6fe45c62b9f2458cdb4e0d"] = true,
    ["FREE_dd34bf99f4630dd469954313e9929f07"] = true,
    ["FREE_4c3f7f610bffa37b12b00c2a4b20079a"] = true,
    ["FREE_bccbed1c2126097c999d12863941cac7"] = true,
    ["FREE_384c839487f202f3106f76df4b06c682"] = true,
    ["FREE_8d00d3f85ca203bc82b86bdef329ef44"] = true,
    ["FREE_2b83a4346f86c4996de9426caa1eb899"] = true,
    ["FREE_b0c56dc7981a914c4527fc0530e68c33"] = true,
    ["FREE_5be2cb56a9926d2cc1bd93b7ce8602cb"] = true,
    ["FREE_d8eb08705459bcfcce4f54ab4322381e"] = true,
    ["FREE_80dee04552f68ab9ff75b7b479b3979b"] = true,
    ["FREE_1bb483fa5e08043cbfccd2c512f4e819"] = true,
    ["FREE_7d1ac4670501fe0a49e85aa0c0182e04"] = true,
    ["FREE_f65b04e4524644499204d8d02cc3d007"] = true,
    ["FREE_f1be76991552a1b05b4dda80fee6e44d"] = true,
    ["FREE_1a265fb15111dea2e138507ebd69204c"] = true,
    ["FREE_397090b3741541cdaafa2e866fea5f73"] = true,
    ["FREE_73782f2acf1c922441b9c545048b9d10"] = true,
    ["FREE_d9ca898e85e7daefc0930702c3eee75d"] = true,
    ["FREE_9b6d71c9da7262e6daebc19522ef864b"] = true,
    ["FREE_9680659db80c383928c1e3e51e770b29"] = true,
    ["FREE_84539f1a7ac5480454556f3daddde768"] = true,
    ["FREE_622e7437e513ba3e550d752d81ea792c"] = true,
    ["FREE_b4595323030be09df54dae3ca2051794"] = true,
    ["FREE_69b1c7130e4808ae7562de04dbb1d47a"] = true,
    ["FREE_81b2207f5bfc7a84dbd24442ad9d38c9"] = true,
    ["FREE_817767df2c506ee0800e61d477262552"] = true,
    ["FREE_6279f3eec03d6a3c580c4a60d35194a9"] = true,
    ["FREE_055cee3c737ec74ce3bc1ae22339aa43"] = true,
    ["FREE_ad975576e9dab9c7d180e7babb3f3474"] = true,
    ["FREE_7e90be9852cd785a60d449d35680e562"] = true,
    ["FREE_7e4e8489384982e389a5161a1a0faaba"] = true,
    ["FREE_25786354700cea59b14060380355bec7"] = true,
    ["FREE_060fcd62a72dfdc0ccdf7210d2e115b0"] = true,
    ["FREE_1d52e307c662f992d1b066bf16c70862"] = true,
    ["FREE_76aec758e4220be712f7df7daf33454d"] = true,
    ["FREE_e6f16960642fc23cb110e43a9e1266b3"] = true,
    ["FREE_445fd814b2395b709d7ad6ff0120d871"] = true,
    ["FREE_c86855ad399cc164a51f49385104859b"] = true,
    ["FREE_64954a8e5a71bc8469c094bd9df1b5a0"] = true,
    ["FREE_24329c4a7af30a672516e75547093e32"] = true,
    ["FREE_23a0daca18914887008ca79862214bb2"] = true,
    ["FREE_d51b24baa0c09860ebdf727e40645f57"] = true,
    ["FREE_818bea98c9ef9f60694596de4682f71a"] = true,
    ["FREE_6c1ed3621a960de72bbc124a7966b6e7"] = true,
    ["FREE_03c58c10fc9bd16291da6cc1ff2a6d3c"] = true,
    ["FREE_d0cd4b8f7be89d8e6340d02cd7d131d4"] = true,
    ["FREE_8f04de8e0873ba94c4ab567ed7adc186"] = true,
    ["FREE_33a73ce542cd9a189809275445e60823"] = true,
    ["FREE_90ca9211d072f25c7ce883d41a872abc"] = true,
    ["FREE_8281b98e784aa17be57a4f9154bfcb4c"] = true,
    ["FREE_017cfdc2927717acc0572f7b0aaf8cac"] = true,
    ["FREE_8493ea5b64ac982e699fa4d6e131dccb"] = true,
    ["FREE_61fcda0807e1bf7c2f52d698f1ebbed4"] = true,
    ["FREE_c533f313af0b50950597a11dfecb3a23"] = true,
    ["FREE_cb6ca05eef2a9691d1c302c86e6cca3f"] = true,
    ["FREE_1ed35aa20db7bc4ef4a352842a09b5e1"] = true,
    ["FREE_c2f087b1ebfa7bd80c47ead1362cfb47"] = true,
    ["FREE_b923de8dd60db3385f8be5544177afc0"] = true,
    ["FREE_741df1dee5fac80b587a52780b8dfef5"] = true,
    ["FREE_5b3097f1b01008cd0c39561569d91e19"] = true,
    ["FREE_6b07ac2a58586ef81b771bd3deae6a3f"] = true,
    ["FREE_35959e2e8b9da15b6bc8c2926d3c7c64"] = true,
    ["FREE_6f2b151254f78a2b922cc5ee06b0d4e9"] = true,
    ["FREE_c7343bbd3b7102f83941f31e13569229"] = true,
    ["FREE_5cb2c174e02973fd69bdd16445c8d5bc"] = true,
    ["FREE_ed76831650a88b1244e07b73c6eea925"] = true,
    ["FREE_df9c9bd80437ab08f53b8a4e4b4007b7"] = true,
    ["FREE_bee5bac31d18e439c062544a4002db93"] = true,
    ["FREE_417aad181c86e7ea16b536fdc3f19b67"] = true,
    ["FREE_14067cf54e5e10669a9d11097e70ba78"] = true,
    ["FREE_d3002efd4f489db11f5e8088fc84ce8a"] = true,
    ["FREE_31c5d352511c862ca07d5684e0b96e42"] = true,
    ["FREE_bc800f02b59a27dd91d82497f15b4c98"] = true,
    ["FREE_b41f4eb3eaf65d1baac46a6fe4be83a2"] = true,
    ["FREE_e34c521dc3f43daceb27f93d110c398d"] = true,
    ["FREE_a6eb96ce6e709c973335650b7c9eac65"] = true,
    ["FREE_545b898e9798c977f09a431723b69812"] = true,
    ["FREE_390614e02b106405f4e2b6fa98dcc8d8"] = true,
    ["FREE_1f2641295c680a67bd23959f6cd37403"] = true,
    ["FREE_2870a5863c0b1b4baf4757125bc92551"] = true,
    ["FREE_6b150216d375b934ccee86f9dd86fb0f"] = true,
    ["FREE_b732fdc6b2754377b08d4355176f04fb"] = true,
    ["FREE_531cd3061c1841a880a23d69316525ae"] = true,
    ["FREE_5b439be0951c2d79dd52f63d8e421a12"] = true,
    ["FREE_1d31f9818c503ed0df5dc322858c4174"] = true,
    ["FREE_138e3cbbfffbced31cbe5fcad1b62e24"] = true,
    ["FREE_21981da1ce7e8628248bdd26ffb03367"] = true,
    ["FREE_046b3c33b561e43edfc26ab5d64c54d6"] = true,
    ["FREE_1da455e49697640c491c4414cf3020ba"] = true,
    ["FREE_e43f649d313fb1728c3c5949c08f0788"] = true,
    ["FREE_01bfc0919fb74ba617a570e0b67c24fb"] = true,
    ["FREE_0647c786a0c2727043479ed3a3e262b2"] = true,
    ["FREE_a944d5f7f95effb0e7f7881e1203d3d8"] = true,
    ["FREE_8896de1943ba715c4fefffb1a9e07168"] = true,
    ["FREE_87adb98153d34bf2d07429fd660b8e14"] = true,
    ["FREE_cd4d7d7d66bfaf55a85bcc11c4e3a1ee"] = true,
    ["FREE_267bc5a4c072e526cd6be8f4e799f70b"] = true,
    ["FREE_420372ff91a894fd6aa18fc83359995b"] = true,
    ["FREE_0dd81483af2e6572493ec33975294545"] = true,
    ["FREE_76495d3b8c30663cd274f96337d71d12"] = true,
    ["FREE_ebb20ed257cbd954e3f2fc3d60601e30"] = true,
    ["FREE_abaea8b5c00533feae5edba689f483c9"] = true,
    ["FREE_12ca0dd5c50ac24292d924cf43049f43"] = true,
    ["FREE_593d66120783585dbbb8e37834d7b9d5"] = true,
    ["FREE_b626bd79ff5e98c5b8c37a319a84310a"] = true,
    ["FREE_65ee1f7a37ef6499b7fd849414269470"] = true,
    ["FREE_2284fb8c80143e98656007cc1b9a8650"] = true,
    ["FREE_015d51094415f8191ff2c65b7e75ba92"] = true,
    ["FREE_f2e0ff6439e3d35e774e53bdac879b90"] = true,
    ["FREE_e187d27b093256368a1a242a7b977bb8"] = true,
    ["FREE_344768eefd719b35b16f2c2a1a750b06"] = true,
    ["FREE_f74fbfa43d5d52f8bad6f0ec644dc13b"] = true,
    ["FREE_59ea6fa482038319dd42cbc835152bb8"] = true,
    ["FREE_a1ebb847152bbd9f4b79d0423182e19a"] = true,
    ["FREE_86ff504badea203cf11277be6583b076"] = true,
    ["FREE_6fe2398e5ee42844d3d3b0682bce1205"] = true,
    ["FREE_aa6aa17d5d347d22deda30877d9565f8"] = true,
    ["FREE_2d22928b3c6de8ab68b2e3d754c370d8"] = true,
    ["FREE_f0738da428add83a3b718cd587ee6fcd"] = true,
    ["FREE_0fdb2afd14e44f342b04c8c832017f07"] = true,
    ["FREE_c6e7b5bdee8293c5742538c2366bb35b"] = true,
    ["FREE_c25b171a68076555810cb59a72b908cc"] = true,
    ["FREE_027d2fc370cc50d0d7a3b096440fd9a5"] = true,
    ["FREE_d8874080742a6686cfad2acedc07b2b7"] = true,
    ["FREE_7c4cbcf0c96b9478ad6dce60e31113d0"] = true,
    ["FREE_e3142eb7300b92e861ec8912ac9d1258"] = true,
    ["FREE_86b235a41c52fd7108db2a06ce944d0e"] = true,
    ["FREE_e86785b45a132c68459dbb1f22bbe8e6"] = true,
    ["FREE_7aff9a853b07617b4634700e32c9b1b2"] = true,
    ["FREE_aeeada005f471f37b50e30c14d77a2ac"] = true,
    ["FREE_39ad5afa9215ace4d949c49b426531b8"] = true,
    ["FREE_0ccaed30cff534480c1c54a62291fc29"] = true,
    ["FREE_04deb4ba6320be7c2ce1a32c02b17587"] = true,
    ["FREE_924647b404352efa41a5ceb545a6b407"] = true,
    ["FREE_38d9b50229fbb3f5e6935a0d76eaaf82"] = true,
    ["FREE_1024da1b2eee36c2fe873c0000f72e52"] = true,
    ["FREE_a4cedce6f1f5c5a2599fd4fb18727d8d"] = true,
    ["FREE_e22179076d6203840e4c774bf8e0321e"] = true,
    ["FREE_7681ddf3de5a272dbccf1cc2a5f17061"] = true,
    ["FREE_9bf5b119c7eeb16276d7d6a5c646008d"] = true,
    ["FREE_4c4242885e066fd9937533f1d1bd347e"] = true,
    ["FREE_5de3ca671b6ed1171ea8b0e8e09c91f5"] = true,
    ["FREE_506717854b8fcba80a28a1b331e2c205"] = true,
    ["FREE_f7b240969c0ba8769e644ac407ba03e8"] = true,
    ["FREE_d84322b49045f6bf82ef1fd2b8b68c14"] = true,
    ["FREE_c3e1f885a57503c6cc18776312b5bb4b"] = true,
    ["FREE_755034ba2c805594be49dc4571503d92"] = true,
    ["FREE_82e50b537ca839b95036bfe07b9ba549"] = true,
    ["FREE_aed81456ff48069638dbffa43c63e28f"] = true,
    ["FREE_a706877c5a372c8c11bceb6b93978647"] = true,
    ["FREE_f31aefb580a9b698989ac2ac4773eeba"] = true,
    ["FREE_a00e3575b8ee8d19014338a75015a1ef"] = true,
    ["FREE_c94d455d5d1d9dced2d5c7bcab00fac1"] = true,
    ["FREE_aebb58f32bf7fa9d8ba481266551953b"] = true,
    ["FREE_2cac10aa4f1167c97df3ed0a60a3715c"] = true,
    ["FREE_5b84934bfb9ea479b7167fa54a8c2bcc"] = true,
    ["FREE_938576a120f8c602334d2206a9d01c3c"] = true,
    ["FREE_34a1301099c3369aa884900517c8c34f"] = true,
    ["FREE_a7242b922cb6e669744d3693e13cc78f"] = true,
    ["FREE_2f6dbd8a39e2402e7a7ec31c77932180"] = true,
    ["FREE_64736c4ed4d88c8b5548976654c32f25"] = true,
    ["FREE_e3bb52e3e84c691dd48fa2d8dfae536f"] = true,
    ["FREE_7545470fa6e99fa1ed80af95803f3e8a"] = true,
    ["FREE_44500e82308e717ef6a50e696cd801a8"] = true,
    ["FREE_c8c5533420e0bfec6f0029e3fff3102a"] = true,
    ["FREE_327d90d1c637ac2580072404af57cffd"] = true,
    ["FREE_22bfaa983e3b617528476d7621f62213"] = true,
    ["FREE_f7b00bd4a4ab05048bd457a0d1f8254a"] = true,
    ["FREE_1de630c356e6d62f5c73c71e98879dc9"] = true,
    ["FREE_01594bd8419380a0b6a29182f1b79559"] = true,
    ["FREE_a66ace53a853b232e1d41525ea980ff5"] = true,
    ["FREE_8a3ab1c3029894ea52f4a7531d8cb00c"] = true,
    ["FREE_3608320938cd9ff5f5091a5123a4e8be"] = true,
    ["FREE_e3ca8a927b0a88913c76046ef3efe08d"] = true,
    ["FREE_4af17ac12d90af1df6915e23aec7d295"] = true,
    ["FREE_067ad72d908c5a860bb054817a41c9aa"] = true,
    ["FREE_b59731ba4eb11e5fa98c35f6ca573be0"] = true,
    ["FREE_62d5180554fc409b4162ce3223403bba"] = true,
    ["FREE_79684ce9378c6df6f43d90996f004c85"] = true,
}

local KEY_FILE = "01ROXHUB_KEY.txt"
local TIME_FILE = "01ROXHUB_TIME.txt"
local DURATION = 86400

local function saveKey(key)
    if writefile then
        writefile(KEY_FILE, key)
        writefile(TIME_FILE, tostring(os.time()))
    end
end

local function checkKey()
    if isfile and isfile(KEY_FILE) and isfile(TIME_FILE) and readfile then
        local savedKey = readfile(KEY_FILE)
        local timeContent = readfile(TIME_FILE)
        local savedTime = tonumber(timeContent)
        if savedTime and savedKey and validKeys[savedKey] then
            if os.time() - savedTime < DURATION then
                return true
            else
                if delfile then
                    delfile(KEY_FILE)
                    delfile(TIME_FILE)
                end
            end
        end
    end
    return false
end

if checkKey() then
    loadstring(game:HttpGet(getgenv().ROX_HUB))()
    return
end

local EL01ROXHUB = EL01ROXHUB_UI:CreateWindow({
    Title = "01ROXHUB | DUELS <font color='#FFD700'>[BETA]</font>",
    Author = "BY 01ROXHUB MATI HUB",
    Folder = "01ROXHUB",
    Acrylic = false,
    Transparent = false,
    NewElements = true,
    HideSearchBar = false,
    Background = "rbxassetid://87524321260822",
    BackgroundImageTransparency = 0.55,
    OpenButton = {
        Title = "OPEN 01ROXHUB",
        Icon = "swords",
        CornerRadius = UDim.new(0, 14),
        StrokeThickness = 1.1,
        Enabled = true,
        Draggable = true,
        Scale = 0.9,
        Color = ColorSequence.new(Color3.fromRGB(20, 20, 20), Color3.fromRGB(0, 0, 0))
    },
    Topbar = { Height = 44, ButtonsType = "Default" }
})

EL01ROXHUB:SetSize(UDim2.fromOffset(580, 460))
EL01ROXHUB_UI:SetTheme("Dark")

local KeyTab = EL01ROXHUB:Tab({ Title = "KEY SYSTEM", Icon = "key" })
KeyTab:Section({ Title = "KEY SYSTEM", Icon = "shield" })

local enteredKey = ""

KeyTab:Input({
    Title = "INGRESA TU KEY",
    Value = "",
    Placeholder = "XXX-XXXX-XXXX",
    Callback = function(text) enteredKey = text end
})

KeyTab:Button({
    Title = "CONFIRMAR",
    Callback = function()
        if validKeys[enteredKey] then
            saveKey(enteredKey)
            EL01ROXHUB_UI:Notify({
                Title = "01ROXHUB",
                Content = "KEY CORRECTA",
                Duration = 2
            })
            task.wait(0.5)
            EL01ROXHUB:Destroy()
            loadstring(game:HttpGet(getgenv().ROX_HUB))()
        else
            EL01ROXHUB_UI:Notify({
                Title = "KEY INCORRECTA",
                Content = "KEY INVALIDA",
                Duration = 3
            })
        end
    end
})

KeyTab:Button({
    Title = "GET KEY",
    Callback = function()
        setclipboard(getgenv().ROX_DISCORD)
        EL01ROXHUB_UI:Notify({
            Title = "Copiado",
            Content = "Discord copiado",
            Duration = 3
        })
    end
})

task.spawn(function()
    local TweenService = game:GetService("TweenService")
    local CoreGui = game:GetService("CoreGui")
    local bgIds = {"rbxassetid://136946652149245", "rbxassetid://94536127566353", "rbxassetid://81982829204229", "rbxassetid://103770971295555"}
    local bgImage = nil
    for i = 1, 60 do
        for _,v in ipairs(CoreGui:GetDescendants()) do
            if v:IsA("ImageLabel") and v.Size.X.Scale > 0.5 and string.find(v.Image, "87524321260822") then
                bgImage = v
                break
            end
        end
        if bgImage then break end
        task.wait(0.2)
    end
    if not bgImage then return end
    bgImage.Image = bgIds[1]
    bgImage.ImageTransparency = 0.55
    local index = 1
    while true do
        task.wait(5)
        index = index % #bgIds + 1
        local tweenOut = TweenService:Create(bgImage, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageTransparency = 1})
        tweenOut:Play()
        tweenOut.Completed:Wait()
        bgImage.Image = bgIds[index]
        local tweenIn = TweenService:Create(bgImage, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {ImageTransparency = 0.55})
        tweenIn:Play()
    end
end)
