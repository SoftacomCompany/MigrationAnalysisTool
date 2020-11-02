object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'Migration Analysis Tool'
  ClientHeight = 553
  ClientWidth = 876
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Arial'
  Font.Style = []
  Menu = mmMainMenu
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 16
  object pcMain: TPageControl
    Left = 0
    Top = 0
    Width = 876
    Height = 535
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 0
    ActivePage = tsSelectProject
    Align = alClient
    TabHeight = 30
    TabOrder = 0
    object tsSelectProject: TTabSheet
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Caption = 'Select Project'
      DoubleBuffered = False
      ImageIndex = 5
      ParentDoubleBuffered = False
      object lblSelectRootFolder: TLabel
        Left = 40
        Top = 178
        Width = 106
        Height = 16
        Caption = 'Project root folder:'
      end
      object lblSelectProjectType: TLabel
        Left = 40
        Top = 138
        Width = 156
        Height = 16
        Caption = 'Select source project type:'
      end
      object btnSelectFolder: TButton
        Left = 591
        Top = 175
        Width = 34
        Height = 25
        Caption = '...'
        TabOrder = 0
        OnClick = btnSelectFolderClick
      end
      object edtRootFolder: TEdit
        Left = 240
        Top = 175
        Width = 345
        Height = 24
        ReadOnly = True
        TabOrder = 1
      end
      object btnNext: TButton
        Left = 40
        Top = 266
        Width = 113
        Height = 25
        Caption = 'Start Analysis'
        TabOrder = 2
        OnClick = btnNextClick
      end
      object cbProjectType: TComboBox
        Left = 240
        Top = 135
        Width = 145
        Height = 24
        Style = csDropDownList
        TabOrder = 3
      end
      object pbAnalysisProgress: TProgressBar
        Left = 240
        Top = 274
        Width = 321
        Height = 17
        DoubleBuffered = False
        ParentDoubleBuffered = False
        BarColor = 542101751
        BackgroundColor = clSilver
        TabOrder = 4
        Visible = False
        StyleElements = []
      end
      object chkIncludeSubFolders: TCheckBox
        Left = 240
        Top = 218
        Width = 145
        Height = 17
        Caption = 'Include subfolders'
        Checked = True
        State = cbChecked
        TabOrder = 5
      end
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 868
        Height = 105
        Align = alTop
        BevelOuter = bvNone
        Color = clWhite
        ParentBackground = False
        TabOrder = 6
        object Label3: TLabel
          Left = 128
          Top = 23
          Width = 467
          Height = 32
          Caption = 'Delphi projects Migration Analysis Tool'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = 13486179
          Font.Height = -27
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Label4: TLabel
          Left = 128
          Top = 61
          Width = 467
          Height = 22
          Caption = 'Migration from legacy Delphi project to up-to-date (10.x)'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = 13486179
          Font.Height = -19
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Image1: TImage
          Left = 15
          Top = 8
          Width = 90
          Height = 90
          Picture.Data = {
            0954506E67496D61676589504E470D0A1A0A0000000D494844520000005A0000
            005A080600000038A8410200001BF84944415478DAED5D099814D5B5FEAB7A9F
            E965F6058119191665117788881A0444111051092AC6A706137763409F91C485
            98B8108D4B5C104113A312970421A8010D8B280808B228CB0C03B3AF3DFBF474
            5575BD73BABA999EA67BA6BB67BA4D9E39DF7798EEBA55D5B7FE3AF76CF7DC8B
            A02E1F8C18298B7819717FE2138845E24A1F3F40BC39AABB599D387474306ED9
            381AA966097A418DB55FBD2259011A5A7578F6E60A0C3DB51EA837F7C97D855E
            003D8BF89D306DCF12DF11D5DDFE0B745862306F0BD3B68E78625477FB9E03FD
            4BE272682A2298B6109F1DE6BAC3C483421C1F437C3EF1E3C7B57C8F817E95F8
            7F7C9F5F24BE93D81DD05E46DC2FCCB512B131E8D8FDC4BFF17DFE8CF842E28E
            63ADDF53A0DF27BE2CE8D87EE26B89DBA0813EAF877BAF265E445C4BFC32F10F
            83DAF7119F0E3FD804F4E19202FC74C3A948F99E00FD1AF175097A2E96EC73BD
            9F6C4EEC2A3C09776E1E811C8B1B3A21413D08A244017D1FF16F13FC6C1FC223
            5E8CAC03D8B9773C6EDC381227D9DAA96709EE858F1205F46CE2B712FA64AAF8
            2C921AEE406B0A6EDD300685CD66A49BA48476219012A93AFE48FCB3043DD746
            E8E5F36068C3FC8F27E21F1529382BAD75AEE4118652DBC204F5A10B25DA181E
            201E12E767626BD70FD6C6CA95BB4EC3C2ED83312AA5CD4007E9E960252E26BE
            8AF8CB38F7A30B251A683EF82DB12E8ECF348DA479153CC095AB2760539D0D13
            B21A678B02DEF2743A1C27FBFAC16442A03B18274A34D09CC7A88096BF88178D
            2583B705A28CFA160796EE1D8C378AB24F7018942B075A5D0FAAAAB084F09EEF
            3B773C34DBF126F10BC485F1EA542281667BBF149DC14A4F74089A9B26139F42
            7C5684D7ED213E8D8CA10C5B9DF757771F1E8697F614604BAD356DA8BDBD830E
            B512D87A3A6F27F108DF751CA5DEF09F083467DEC6125F002D8018E0E348E86E
            E2A7838EFD089AE445421CDE9712D8BBA09337C251B6056EC781C51BC6E391BD
            03F0C38C26D88C8A4DF1081CEE9FECBB86C3F8ADBECF9712B7127FFA9F003427
            8026C470EDCF899F0AD33689F8E3A8EFE8111B606BC884DB2CBFB77738FE52D8
            0F32E9F06483875B7984716EC5EF11B1A4FBFD40FE2D8E548FF4169078027D10
            9AF18B86585DF4E495FC13D166F0983C62264CAE5A641CC5B2B5D3F0C49E81E4
            F2B540568F8B601E46571730135AB8DF2B8A27D0DCB9F428AF6383744B0FE72C
            F481112D9D0876ED2C4D901AB330F363B29984B1DD20079FC7B99305C4537C7D
            79C1779C7334BF8216E5F2E4434B343F1E4FA09DF43725CAEB9E819658EA8E02
            B375D150017111E96D20ED08DEFEE242FC7AC7208CC9680E25D54C67424B7835
            131BA019CEE1BEB65F23CA97FDEFA63AB6A167EFE2AFC45744795FF6A07389AB
            BCDF2C64E7C8F59BF9D1B9685704645068DE434E6F20BAEAE9B37C7D65E2E4D5
            2E682F242CC513E8AFE9EFA818AE6510DF0DD37612B434682CA9210E4CB4BC37
            4B754A19D67DFD033CB06D30F26DAE9E1C7B6ECE23BE179A37728FEF781A31F9
            90A8813633C423CD9368A03918B8089A8BC79DCC8766D1232176AF56071D63CF
            E03D6813B691104B600934C9DB84E097676AA778D08C9BD68D4345BB11294639
            C2DB76A1B5D0261A98D8267140167270243260E159933F2172978FBD8B1DD002
            16F6752F8FF03A560F3F8036ED159EF46E2FD0376F1883A3AD26A4C506F4ADD0
            A6E5582D4D27FEC0779C73292C2C3C023812069B816F8E1AB0FCF64A8C3E97BA
            58931437A099F8201B987886E0338857F67896C10DB53D09F3369C8DF2B69825
            9A29199C5FD1668F3867C286B3189DD371B3F53AAC3850AEC7A813643C795B09
            EC692E5240863E79D87040B34EAB467C934A1C857ED5E35904B4D266C58DEBCF
            426D87010E43CC400713ABCACFFD5F7422461455EAF78DE82FE1A5FB689059E8
            77EAC85CE8FA664A2D1CD09FFB3A124F62E3C44146F74F62D054C795E4791493
            EA186C6FF74E73A9313E7FAB4B1BA4C9668F8DFCF30BE83E8F92247F5856AF9B
            EF7209F8E0A123483D893CDEA3B63E03992914D0EC7B3E1827708329B20491A5
            1DDF96E4E1BE2DC3E174EB906376C3A0577B043BB09D016E6A13919DA28D889A
            261D526D0A9249689D2DA2DE2D0BF233F32A31F44CB29555498C4C9F3E6830D0
            6C00D72504E24EBA1EDA8470F794DC04B45BF1FEFEA158BA7F206C26198247E1
            47F0468E8164D00B68681151DF28783D446ECFB02B38B5A00377CFA8816A52F0
            EAAA6CFCE5132BCC26152EB7803FDC50831F5C460E50B1E354788467099954BA
            95059A9D22D7070DD0F23B5FF405D05CD8323F961BF582384C1ED7ED195EE1A2
            E7CD3C00B8FAE1EA151350D56E40AE5D24103D9024CD25D6EB052FF0CE161979
            592A7E747E0B446A3791B33AAC7F3BECD96D7412DD4CA4F30511BB76A4E1FE57
            B330728084C7EEA3B8ADC9481EBCEE6642E5C5303D7989F8A77D0134FB322CD1
            F1D6CF7E2A85E6E295760B32CB9495620DD98AA73E3F07EFEC37C2E691919595
            029D4E466BABE4955A838181D66167511B7E3BB709D3E695918E203FD843C75D
            64D7E9E54016B47BF2A459662B3C2576B4778848CE220FA385DE88A87215C07D
            617AC3B6EB9CBE009A29385FE0278ED678969C7A848710BE1CCC4FEC1F73BE83
            2B9AD8A50A4E5CF17D86111F0D0F32216CA4D3AC65D877E82C3CBE63180EB658
            91A3AB839B1CB4D4341B4492CEF6762D5BEA077ACF11171E9EE3C4F42B1A814A
            63A83B73C2AB9C5EC05258496793D4A3D9C82073DB2738BED8C74FFC2CFD431C
            67C19C8C6EF22AE1BC0EF639FF86CE3427477ABF40D7E082C3D98C30F7E5B19C
            E33B8789F5DD93E8347CC5BE8E1D0C793549A977789B298A960D786BE7697866
            6F3E193715431C12DADB5A490AC9070D03F4DEA3ED587855232EBF92D46AD571
            402F27FEB1EF3367FC7EEE7BE97EE267CC0FF7EAA1A50802EB21EE42675E9E5F
            12C707C7650C7B2A72E4793A9E9FFB6588368E064F0B731D87D403E12189B491
            11D313688D76EEE6ADA44227FA007776F6825F0D9D9BD44C124CDC42EF4FD600
            FADDB653B0E4603F8C72B4C06154A0404FC0B6A22336A0395D7049505F19D8E9
            3EB06FF77177391A0EB21E81365BCFA56E1706B5EF85360BD41A0DD0DD516011
            64306DA2613F9EE702771E1A8AEA563D269FBE8B940FE9CBD6144D5A4D849481
            8C93409E8347EF05B8B96228DE2BCAC33EA70DF51D7A344B7A327A46F44BEAF0
            3E398B9320E87A04FA6B521D8F5FE7C49499047499D9EFAA2D47A724C79B384B
            C801D9B1C4556F809E4BFC7AC816555C42D2390FB21953FE7A1ED69779F0D8F8
            26DC36E200C48C22AF514343260E3739B0A32E0D0D04AA8522BE3547B2F1458D
            0DFD93DC48D279A0279D690D8A0423019A257AC1CC26CC21970D47BCB90AB629
            BF4A10C87E62D53BB32F80CE27DE004D4F5B7CC778F83591C4DE0847E9AA659B
            A660F1CE6CE419AA5022F4C7E8D4362C3CE31BD4B559F0EC9E7C9256131A151D
            0C24710A095D8E49429A5982E4093F722301BAA5B5150DAD3296DCD682216793
            2AAA34CD2543F73A124B8BA1D9B55E03CDC48E171B3A1B34BDD642E3BB096925
            1D5BF68CC1CF368FC0A0E4B659A2D231CA6C312D6A94203731A224E94602D74E
            3AD7CC119E2F0A8F24AC0E069AFD68069ADD3BF6A30541BC5910647D591D9E3F
            214DC09F1E227321B8D9AB584C4FFBF30481CCD5555DBCB2DE02DD9558127348
            2FD60DC2B435E3E091DDA6547D738920EA321545A9D1E9AC937406DD2EB7BB85
            DA6492461DB117E29881D6918A613F5A513CB92693EECFA2284ED0EB4D282EFE
            26ABA8B4A5E6F6E902E62F20435CEB618DC9AE64A4A514B1120F2F9E8E2B891F
            D0960E94555871F7C61128759950E050E7A982F92555D54265514CE92F084299
            2C37C2E3910D04B4142BD02E525229295658AD226499BC11454D5755A1469214
            41A713E16A6B7E755F096E6CEF3062CB3375C8CC27EFA7D1980FADAEB06F729F
            A18953B1AB8EEB779F01CD29B5140163EE28C7D6C3AD04AB8A11C347E79FFFC3
            89339CCEBA07743AE1551ADEF7D6D6DA4897CAA7DA6C2DAB3D1EF15D02FE3582
            787B3440B7B5B5C0ED862125C5F1845E2F6F1445E15D8B2599A4BC6392ABBDED
            E3C636DDF2A355E667CF1B25EDB8695A2D4E19D80081436F59645BD21867A079
            6EF2B3F8026D3762DC1DFBB0F98886D8D0A1C33179F2256868A87198CD3AB9BC
            DCD95A58A8080505A9EB7372F4E35D2E0F01A7AC273D7B814A51A0AA72FA3B3C
            DA1CB0E874AC6ED40B25C9F367F8822287C3D6DFED56DDCD8D2E720B0D236C7A
            F7DE6B2FAAC7AC89756441DA011A65147A8B6410F99A39113E11C70F3CBDC6AA
            6034229F57E5A413171075095AFA18680326CDDF8FB50714EFA1934F3E051326
            4C4263632D834392C87AD9AD231D4AC6C2709AC9644172B2E5CCE666E776974B
            2110C5CB7D1D0C59E5C42AA1B9D94D922B9D62B79B76190C3A52412ACC66C375
            22D9BD4DBB8D183354C1D3771D424A8173106A9226A3453F123A95E7424F45E8
            F039147162EDC9A063DCB77723BCDEE97B491C0CF14CD54709039ABD03596689
            655D6DA4CFE24D4D4D25C3F6EFFF76FE8811A3919191914C43DF2F05ACE36E84
            36CBC3C4B987DB4C26E3FCAA2A675151D1510C19D27F115D73BDDBDDB188647D
            6579BDAEBC205BC563B79421AD8082B6129B56EA167D5E998B729E08D3C66983
            8F6240A7545097DABA690F9E91EF660A9181B689B8E89E067C5C8C9040BBDDDA
            F5064332192F23B66EFD00841AAEBDF606025F7C4A92A4BB7C77E3E1CAB32FAC
            4F7FE17F70521D6B0C0671AAC723A83C028C46D54452DEE16CD55170E3C1FB0B
            49807229F22DB5F2EC4877298270142E691448A1C2F89EA85AF0BC7E6AC81681
            409604FDB1A05FCB2CCAF43734D802039D65C7B8D9EBB1B95E3B366CD8084C9A
            7431EB68D6C534E4455F3AD34A5E8388BD7BD721377720468E1C8DAAAACA8904
            1A47526CB5D9D9FF83EFD65CEEF57CC04F9D48BF56CCFA9A5C46AF712C711AF0
            AB2B6A71D1E5E45195DA582172B7F9750F8C1290C7103E45EA27562B8F4770AF
            406A10F079B8B5F12AA3D7699BBCC90605DDE65B522976F9F610702FF565FFB7
            5D80662346B8B01BE6551D9CAC6F6E2E47696909017D3A051B3A2F70D0923623
            D1B9F2964B722FF07D7E8EF81E0A4ADC46A30ED5D5AD742F139A28BA7C64760D
            C65F49125D98E6377CEC33475A5BE2270ED31FE9E11C2ECA7932827B0552A380
            6D07BB690FD66F3D141E4932D9E6216406B662EAA38FC264D0C39A9EEEF51638
            382117CFEBFF720988C924902A51B062C59F3076EC3806DBDCD0E0DC46EE9EBF
            E09C6732387BD810F00B5CF852C32F8DA2C0F1E5E56D3B4D2643B3681661377B
            B0E8DA5A0C184676A8C5487D1176906447AB3A38F336B28773D873B926CAFB56
            0AD8B223CA6B7AA0E4648A0CEB71D3B26590DADBE1267740AFD7B30E2616487D
            F0CB53E99837178777DE5991442AA56DCE9CD91CE53D2049B25FA278A8F11C26
            BB702C692E59F6DCEA039982134FADCBA556D3CB7BC96C527EE36CD175D4B624
            E19139E59830935548F22EC8BA53623086EC5DBC1FA66D88EF6544EB87BBFB1E
            681BE9C8A325B87AE952D2340A448BD90732EB67966295FEAA668F471A4E3AF9
            45974BEF763A5BCE4D4FF7C06249A276E1336A6775C119B78004BB42A3C041D7
            66D0A8A8FABBA2344F37D088E17BD20B3099CD82BBD965447DA38ADF5D5F8DB3
            26965D44923D15B5A67C328C6C88220DBD395DC8F9E93541C7D98FE6D2B2AC08
            EFC3931E1C8815136F4C20D03A3282A0F05921DF17271298452495484AD2D377
            C79CAA2AC35B49494EF2895DF43DD8E0529C49E7EA74AAD7985260731785DA77
            99CDA63C8BC53A9DBC950F1C0E233ADA5B2F2F2C754F6D71E91F9B39AEE9C04F
            A75523298B0296DA24F2293DF9D0CA1BCE8FF04918D47F7ADFB036AF392BC2EB
            D86F66A3CE3EF4B1999B8400CD8106819761B5EA9CA41A94A6A6365627AB490D
            5CE2F1F0E4AA6121C5EF8B4CA6167A196E0232D8166869FF8E8E6632A21D7038
            32C9B5B39A2A2B4B2E2F2C3CF0E669A79D897EFDFA1BCBCBCB0BC98DECAF287A
            1CACB24C29C8923F7AFE8E23C8CC6DD2F4B6E685F06A857886E05C08FFF7E083
            7D0FB4C3011C3C846B5E7E0934A0219A8C59E4254C5714CFEF4955BF48D1DC02
            974BA6E1AEE61B8D86A79B9BDB9F686CACFE6CD0A01C0252F085E1C777938196
            A436F24C24320329B0DB33C90FDF842FBFDCEC0DF5870C193A3523236B958786
            8B8B2CAEE46E1AB279BFF9D0CD93553C7C3FB9C7D546BE059786B2F36989EEA1
            A2A2C09AEC38026D3291669570D573CFC15E5B0F35277716456FEF107B253525
            25F94CBD5EDC5E5BDB466AC0E895D2C64627060CC8615D8BD09ECDF1405BAD69
            D8B76F17D6AF5FEB3D232F6F50E68C19579ED3D454FBA0D3E9DA78F848DD1D35
            E454BD79BF84F3A791AAAFF2DE97F3C467C61164262E9DE070BBCBE2D3BE029A
            9F8215AB5701239382BAC2225CFCF042B4EB55B32335BBC4614FCF5014B982F4
            C935140C7DAA7094A833A39DA2EEBE007AD8B091983CF962D4D696C168308985
            B5299E1BCF6FC2F5D71DD02AA23DBA58FCDF5889DDD22EC9ABDE00CD6ED71268
            F51A1C18F098E775837584C9220C1EF459D6138B71E21B6F23FD8CD3A764A5A6
            9E859A8A47BCEFC36C26D0C8ED6A93D1AE9351EF6A431E01EDAD38D245A63A82
            813EE9A491DEE0A8AEAE026514295E72460716CC2B22B9327061CCC514C0FC23
            4120FBE97A0494BAF506E82B8957846C51D5E7906CB91DA201D73DFA0A0CC587
            E1B176C0396A383E3EE71CB4594845BA654CDBB21DE29EAFD1545282FCBC5CC8
            92E22DD5F2242543D507021E39D025E595DE7BAC585006C38066A02289F31E89
            DCB1C14FECB14CEE0BA0391CBE354CDBA7A44226209754C8D6DD98B362352A2F
            381D9F4EBE1030920EE779289E5A9149773230D5D5649E4CDEEECCDCB011D6FD
            FB2174B82190D7A2D8ED908945458E08E84347AA9097A5E0853B697071D1BACB
            FBC2F81F2E6E392F412073D69123DC63EB1E7B02FA77D01CEE50457FDDD550D3
            984501789B023B458AACB7F54676A2C710C83308E4FBBDD329AC2658BA99158F
            B71A1CCD248524E123AA6B91E476A360CB1730151F85949D094995A0C81DDD02
            7D90803E31DB833FDE424027497EA099D8BFDB076D3E2F90D83070A91BEF15F5
            BFF06F3D149E782AEC4168ABBBB8802637A89D53BD1C2075D918A03BA019DC9B
            7D9F3993C679DAD87609A3080EB2723701FE7B5F8D2D4B17AF1D69EF721583CF
            510D87F146A35797E3E8515CF6DEFBB06FDF0149AFC065B3C26AB187057A4F51
            15C60E51F0E8CDA5DAFDA42EC10FF99EF83040403E2493713B69A54301699DF2
            10E005124F22F8EB05797D26AFB99C1B2060FC5CDF045F140E6876B8A7071DE3
            9B5CE60387DF7C4F05E48C00A714D96FE544CCF8A0768EA03881137EAD048F84
            D4146F3771A484007F0BC69DDB613A79340D9434ECDCB9059F7DB6DE7BEAE0C1
            27E3D24BA7E3ABFD95386FB81B0FDFCBDDA5EB3B741ABB7C95A49CFBF0086FC1
            A01E448A6BA1D75762A96F3C56E4C8F37DE12A465925648738CEBB564E855677
            E70A756128A0D935998DBE232D7B149AF8A1382456BA059BA53C97064F65252E
            5DF23CD2ABEB6048CB4145452976EFDE499AA6D89B929D38710A19C36AA45270
            7AE7F406D8926450E0899C340936AE8D4E9635B08DAAF7EFC6B53958B9D5861F
            5FE8C4C8B15CE96F61B079B78670AB82397711931F1E0C344BEAA37D087224C4
            534353BA3D8355804A809F321A58BF01D72D5E0C293D0306522D9C88AAABABF5
            269728D2844812DBE61250DF2A7A3D4923B12349C14903DC9836B6052976B7F7
            F8BA2F1D78F9433BEA5A448C1A20E3DD8587614C27616C30DD4252FF7C989EF0
            B2C098B6AA0B069AD7DDBD9D60A0BB5F57CE12CDBA9A3C0F3692B3DEFD1B928A
            8BA1D892A02DAB60808DDE49034992BCDF9914DF18E1E1D4417A9A975A885CCD
            6452BDCAAA83DA73D3946BCD06B5697BA171E582194D983B8FECDC51C738BA88
            01E50A2CDEDB89AD291B3ECE8B738E7C0D62A050AA23D008C69B3A37180C4722
            7B26668CFBE45F2858F30FF2AFF590521CE4EE7922FB8500E26A34DF24D13072
            D35945F048EA704982DDD9A2732FB9A5020567930A294F6215C235E20E1FD00C
            327B1331AF200A670C79D970B4F36DB1107B2D15DD9E91918133D67D8251AFBC
            0AB95F3F28C9161AD9BD5E31C52B7CF7F9BF9057B9B0AC5EB7C86156B1F41725
            48E56516AD7DBBC4321CD09C14611725D235E1B150C8D2A9E3282B1313485D0C
            F86035DCFD7363059925936769381FBDC777CC6F8FB8CEFB3972E9BFDA76C880
            47663760D6D5E4BD55F46D822F1CD03CD5CFFE643C810E994E3CBE271918B76A
            0D0AFEBE127276662CBF7335B43880CB8B7951BFDFCDE450942BF337F84F3C54
            A1C77DB31A30735609397289019A6B89E746780F76DEFDEBABB9DEA1A7C94D3F
            F18819DEE359BD079AB7BBF86BC077DEC92164255461A51EBFBCC28969334BE3
            0234AF8C6283C4138F1C31F1DCDAA008AF67479D1336817E30A70797E3F8FDA3
            4311BF24CEDF729E9803185E1BDEB960923D8EFE27E08C351F63E49B6F41CACD
            8EE0965E20D9056383EEAF7C5AEF7B365E9FC2E50C95DF05D03C9CC6C5706DA8
            FA343FC55A3AC5A382ADBDF6E238F761B363EA9FDF40FAD66D90D3537BBAFEF7
            D0B688630AACB8E7EA235683C5DD5D1C6FA05992864679DDC108AE09DC8C2452
            624BC7B3CCB55E69CEC9816EE72E5CF3C7172067A4E3B8B5C8C713972A3C10F0
            9DF3E4E591FE78BC81FEF7DC258CA5998294E9E4D6A5ECF80A527656A0C7C188
            5304E32DE1E2171EB8890B67D778E7045E46C10628E2FD4CE30DF4BFDF2E61AA
            5A84EC6CA46EDB8E692FBD0C990C629034B30E61FD6EF57DBF09DA369F4C3C01
            EB8AFCE73A29DE40C7B24B5824C995587609E3D8398724B90AE9E9B8ECC9C5B0
            EFFA3A589A9938E7C6AB7967F8BE73581C6D85E771146FA079DDF7E818AE0D59
            BFE023F664F621DAAD82582FA7A5992049EE89AB562167F317F0582C3A52235C
            25C4C68D739F3FF19DCD46F35FD0BC08DEF9AB21AADF0A41F1069A030776EA79
            B9161B8FBC28AE67290A4EB2F04BE3E47A4E84F72827804B6030EC4276D64AB4
            B6ADBEEC95A548DDB809EEBC3C788C86B3058F674BC0F9BCC4392E7B8AC41BE8
            E063AC46785F8A487709E3309A55897F97B0AB23BCAE9274F144E26F9191A178
            1D8EDD7B70D59A8F602E3A9C42C10917A1B3BEE04AF9DDE81480EEDCCA5E51A2
            81664ACC2E6182B012460350538FE96BD72275EBD654D56CBE5A4A4F5B442FE0
            36D2CB6FF8CEE520843D185EFCBF365E1DFA2E80665F96FDCF78EE12361666D3
            169E11BFF6B127A12B2B877462DE5DAA283E1560F838423DDC8BDF888ABE0BA0
            BB9B37EB2BE2A55AD9B0DB3C53DF7C1B99EB3E4547DE807EA48FCB7CED6CDC58
            1F6F8F733F8E51A281E674E243097932557D05C9C93FE1A9AAD94F3F03D39123
            70F7CBBD4754149EAEE77C4542FF1FA74402CD2173DC74604852941B28385986
            92520AB55F84284950BCC53489A74402CD21ED82043FDF2672EFC6233F0FA3C8
            E338FD2F6F42CA8A291DDA6B4A24D02C4AFF42E27609E31D00D88FAFE229ABFC
            2FBEC0796FBC01D991124902A9CF29D13A9A7F810DD0C941C7B97086B7CAE16A
            25FE9F397BDABF9F234E4E5B72EE972712820318CE4770E25FF32A525361FDFA
            6BCC7CED752849C95A8A34C1F45D781D1C247099AB7F869A3F73923FB09EACBB
            5DC2D88871E2A7D1F79D3795E544947FD9187B16FCA2BE3D7605AF51DCB30773
            972DFF5E01ED2796C46284DE8FA8BB25C03C6B126A151497CE72C4C9F511755D
            5A0868C3EEDDF8D1F2D7BE974077473CA37C7D98B69EEB3582E9BF4087A5F0BB
            84692B017AFAAF52BBD27F810E4B3C13C25BB8B33EB7C3BF7995C6F3D1B9BD7B
            64F4FF1CE8FF03D4D2F5B02C0C04710000000049454E44AE426082}
        end
      end
    end
    object tsSummary: TTabSheet
      Caption = 'Summary'
      ImageIndex = 4
      object gbBDE: TGroupBox
        Left = 24
        Top = 296
        Width = 713
        Height = 193
        Caption = 'BDE'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object lblBDE1: TLabel
          Left = 11
          Top = 25
          Width = 276
          Height = 16
          Caption = 'It seems your source Delphi project uses BDE. '
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object lblBDE2: TLabel
          Left = 11
          Top = 47
          Width = 58
          Height = 16
          Caption = 'Reminder!'
          Color = 33023
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = 3514351
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentColor = False
          ParentFont = False
        end
        object lblBDE3: TLabel
          Left = 136
          Top = 47
          Width = 531
          Height = 32
          AutoSize = False
          Caption = 
            'BDE is outdated and is not installed by default in RAD Studio 10' +
            '.3+. If necessary, you can download it from Embarcadero Customer' +
            ' Portal:'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          WordWrap = True
        end
        object lblCustomerPortal: TLabel
          Left = 420
          Top = 63
          Width = 170
          Height = 16
          Cursor = crHandPoint
          Caption = 'https://my.embarcadero.com/'
          Color = 16744448
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = 10064945
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsUnderline]
          ParentColor = False
          ParentFont = False
          OnClick = lblCustomerPortalClick
        end
        object lblBDE4: TLabel
          Left = 11
          Top = 85
          Width = 104
          Height = 16
          Caption = 'Recommendation!'
          Color = 33023
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = 3514351
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentColor = False
          ParentFont = False
        end
        object lblBDE5: TLabel
          Left = 136
          Top = 85
          Width = 561
          Height = 32
          AutoSize = False
          Caption = 
            'You can migrate your file/folder based DB (Paradox, dBase) to up' +
            '-to-date RDBMS, as Interbase, Ms SQL Server, MySQL, etc.'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          WordWrap = True
        end
        object lblBDE6: TLabel
          Left = 136
          Top = 123
          Width = 561
          Height = 32
          AutoSize = False
          Caption = 
            'You can change your data access layer to FireDAC components. Det' +
            'ailed guide from Embarcadero how to convert your BDE components ' +
            'to FireDAC components:'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          WordWrap = True
        end
        object lblFireDACMigrationGuide: TLabel
          Left = 136
          Top = 158
          Width = 545
          Height = 16
          Cursor = crHandPoint
          Caption = 
            'http://docwiki.embarcadero.com/RADStudio/Sydney/en/BDE_Applicati' +
            'on_Migration_(FireDAC)'
          Color = 16744448
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = 10064945
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsUnderline]
          ParentColor = False
          ParentFont = False
          OnClick = lblFireDACMigrationGuideClick
        end
      end
      object gbProjectsStatistic: TGroupBox
        Left = 24
        Top = 16
        Width = 331
        Height = 161
        Caption = 'Projects Statistic'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        object lblInfo3: TLabel
          Left = 11
          Top = 24
          Width = 91
          Height = 16
          Caption = 'Project Groups:'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object lblProjectGroupsAmount: TLabel
          Left = 136
          Top = 24
          Width = 7
          Height = 16
          Cursor = crHandPoint
          Caption = '0'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = 10064945
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold, fsUnderline]
          ParentFont = False
          OnClick = lblProjectGroupsAmountClick
        end
        object lblProjectsAmount: TLabel
          Left = 261
          Top = 24
          Width = 7
          Height = 16
          Cursor = crHandPoint
          Caption = '0'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = 10064945
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold, fsUnderline]
          ParentFont = False
          OnClick = lblProjectsAmountClick
        end
        object lblInfo4: TLabel
          Left = 191
          Top = 24
          Width = 52
          Height = 16
          Caption = 'Projects:'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object lblInfo5: TLabel
          Left = 11
          Top = 56
          Width = 81
          Height = 16
          Caption = 'Units amount:'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object lblUnitsAmount: TLabel
          Left = 136
          Top = 56
          Width = 7
          Height = 16
          Cursor = crHandPoint
          Caption = '0'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = 10064945
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold, fsUnderline]
          ParentFont = False
          OnClick = lblUnitsAmountClick
        end
        object lblInfo6: TLabel
          Left = 11
          Top = 88
          Width = 96
          Height = 16
          Caption = 'Project versions:'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object lblProjectVersions: TLabel
          Left = 136
          Top = 88
          Width = 57
          Height = 16
          Cursor = crHandPoint
          Caption = '11.0, 12.0'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = 10064945
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold, fsUnderline]
          ParentFont = False
          OnClick = lblProjectsAmountClick
        end
        object lblInfo7: TLabel
          Left = 11
          Top = 119
          Width = 196
          Height = 16
          Caption = 'Total amount of records (all units):'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object lblLinesAmount: TLabel
          Left = 236
          Top = 119
          Width = 7
          Height = 16
          Cursor = crHandPoint
          Caption = '0'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = 10064945
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold, fsUnderline]
          ParentFont = False
          OnClick = lblUnitsAmountClick
        end
      end
      object gbStatistics: TGroupBox
        Left = 374
        Top = 16
        Width = 483
        Height = 274
        Caption = 'Source Code Statistic'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
        DesignSize = (
          483
          274)
        object lblInfo8: TLabel
          Left = 11
          Top = 199
          Width = 224
          Height = 16
          Caption = 'Standard Delphi used classes amount:'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object lblStandardClassesAmount: TLabel
          Left = 241
          Top = 199
          Width = 7
          Height = 16
          Cursor = crHandPoint
          Caption = '0'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = 10064945
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold, fsUnderline]
          ParentFont = False
          OnClick = lblStandardClassesAmountClick
        end
        object lblNonStandardClassesAmount: TLabel
          Left = 394
          Top = 199
          Width = 7
          Height = 16
          Cursor = crHandPoint
          Caption = '0'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = 10064945
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold, fsUnderline]
          ParentFont = False
          OnClick = lblStandardClassesAmountClick
        end
        object lblInfo9: TLabel
          Left = 307
          Top = 199
          Width = 81
          Height = 16
          Caption = 'Non-standard:'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object lblAssemblerCode: TLabel
          Left = 11
          Top = 225
          Width = 416
          Height = 31
          AutoSize = False
          Caption = 
            'Assembler code injections were detected. We recommend to re-writ' +
            'e or refactor all assembler blocks.'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = 3514351
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          WordWrap = True
        end
        object gbPointers: TGroupBox
          Left = 11
          Top = 20
          Width = 462
          Height = 101
          Anchors = [akLeft, akTop, akRight]
          Caption = 'Pointers usage'
          TabOrder = 0
          object lblPointerUsage: TLabel
            Left = 11
            Top = 24
            Width = 29
            Height = 16
            AutoSize = False
            Caption = 'Yes'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = 5230839
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblPointersDescription: TLabel
            Left = 46
            Top = 24
            Width = 403
            Height = 65
            AutoSize = False
            Caption = 
              'It seems your source project uses Pointer-operations. Embarcader' +
              'o doesn'#39't recommend to use pointer and unsafe memory operations ' +
              'from RAD Studio XE4. That can be critial for Unicode and 64-bit ' +
              'support implementation.'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Visible = False
            WordWrap = True
          end
        end
        object gbUnicode: TGroupBox
          Left = 11
          Top = 127
          Width = 462
          Height = 66
          Caption = 'Unicode support'
          TabOrder = 1
          object lblUnicodeSupport: TLabel
            Left = 11
            Top = 24
            Width = 29
            Height = 16
            AutoSize = False
            Caption = 'No'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = 5230839
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblUnicodeDescription: TLabel
            Left = 46
            Top = 23
            Width = 412
            Height = 32
            AutoSize = False
            Caption = 
              'Detailed guide from Embarcadero how to migrate your strings to U' +
              'nicode:'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            WordWrap = True
          end
          object lblUnicodeGuide: TLabel
            Left = 101
            Top = 39
            Width = 354
            Height = 16
            Cursor = crHandPoint
            Caption = 'http://docwiki.embarcadero.com/RADStudio/Sydney/en/Uni...'
            Color = 16744448
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = 10064945
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsUnderline]
            ParentColor = False
            ParentFont = False
            OnClick = lblUnicodeGuideClick
          end
        end
      end
      object gbPlatforms: TGroupBox
        Left = 24
        Top = 185
        Width = 331
        Height = 105
        Caption = 'Platforms Support'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 3
        object lblInfo13: TLabel
          Left = 11
          Top = 25
          Width = 170
          Height = 16
          Caption = '32-bit target platform support:'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object lbl32Support: TLabel
          Left = 198
          Top = 25
          Width = 29
          Height = 16
          Cursor = crHandPoint
          AutoSize = False
          Caption = 'Yes'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = 10064945
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold, fsUnderline]
          ParentFont = False
          OnClick = lbl32SupportClick
        end
        object lbl64Support: TLabel
          Left = 198
          Top = 57
          Width = 29
          Height = 16
          Cursor = crHandPoint
          AutoSize = False
          Caption = 'No'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = 10064945
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold, fsUnderline]
          ParentFont = False
          OnClick = lbl32SupportClick
        end
        object lblInfo14: TLabel
          Left = 11
          Top = 57
          Width = 170
          Height = 16
          Caption = '64-bit target platform support:'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
    end
    object tsProjectGroups: TTabSheet
      Caption = 'Project Groups'
      ImageIndex = 3
      DesignSize = (
        868
        495)
      object dbgrProjectGroups: TDBGrid
        Left = 4
        Top = 4
        Width = 861
        Height = 457
        Anchors = [akLeft, akTop, akRight, akBottom]
        DrawingStyle = gdsClassic
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = RUSSIAN_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -13
        TitleFont.Name = 'Arial'
        TitleFont.Style = []
        OnDrawColumnCell = dbgrProjectGroupsDrawColumnCell
        OnKeyPress = dbgrComponentsKeyPress
        OnTitleClick = dbgrProjectGroupsTitleClick
      end
      object btnExportToCSV2: TButton
        Left = 3
        Top = 467
        Width = 126
        Height = 25
        Anchors = [akLeft, akBottom]
        Caption = 'Export to CSV ...'
        TabOrder = 1
        OnClick = btnExportToCSVClick
      end
    end
    object tsProjects: TTabSheet
      Caption = 'Projects'
      ImageIndex = 2
      DesignSize = (
        868
        495)
      object dbgrProjects: TDBGrid
        Left = 4
        Top = 4
        Width = 861
        Height = 457
        Anchors = [akLeft, akTop, akRight, akBottom]
        DrawingStyle = gdsClassic
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = RUSSIAN_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -13
        TitleFont.Name = 'Arial'
        TitleFont.Style = []
        OnDrawColumnCell = dbgrProjectsDrawColumnCell
        OnKeyPress = dbgrComponentsKeyPress
        OnTitleClick = dbgrProjectsTitleClick
      end
      object btnExportToCS3: TButton
        Left = 3
        Top = 467
        Width = 126
        Height = 25
        Anchors = [akLeft, akBottom]
        Caption = 'Export to CSV ...'
        TabOrder = 1
        OnClick = btnExportToCSVClick
      end
    end
    object tsUnits: TTabSheet
      Caption = 'Units'
      DesignSize = (
        868
        495)
      object dbgrUnits: TDBGrid
        Left = 4
        Top = 4
        Width = 861
        Height = 457
        Anchors = [akLeft, akTop, akRight, akBottom]
        DrawingStyle = gdsClassic
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = RUSSIAN_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -13
        TitleFont.Name = 'Arial'
        TitleFont.Style = []
        OnDrawColumnCell = dbgrUnitsDrawColumnCell
        OnKeyPress = dbgrComponentsKeyPress
        OnTitleClick = dbgrUnitsTitleClick
      end
      object btnExportToCSV: TButton
        Left = 3
        Top = 467
        Width = 126
        Height = 25
        Anchors = [akLeft, akBottom]
        Caption = 'Export to CSV ...'
        TabOrder = 1
        OnClick = btnExportToCSVClick
      end
    end
    object tsComponents: TTabSheet
      Caption = 'Components and Classes'
      DesignSize = (
        868
        495)
      object dbgrComponents: TDBGrid
        Left = 4
        Top = 4
        Width = 861
        Height = 457
        Anchors = [akLeft, akTop, akRight, akBottom]
        DrawingStyle = gdsClassic
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = RUSSIAN_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -13
        TitleFont.Name = 'Arial'
        TitleFont.Style = []
        OnDrawColumnCell = dbgrComponentsDrawColumnCell
        OnKeyPress = dbgrComponentsKeyPress
        OnTitleClick = dbgrComponentsTitleClick
      end
      object btnExportToCSV3: TButton
        Left = 3
        Top = 468
        Width = 126
        Height = 25
        Anchors = [akLeft, akBottom]
        Caption = 'Export to CSV ...'
        TabOrder = 1
        OnClick = btnExportToCSVClick
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 535
    Width = 876
    Height = 18
    Align = alBottom
    BevelOuter = bvNone
    Color = 13486179
    ParentBackground = False
    TabOrder = 1
  end
  object mmMainMenu: TMainMenu
    Left = 684
    Top = 363
    object miFile: TMenuItem
      Caption = 'File'
      object miNewAnalysis: TMenuItem
        Caption = 'New Analysis'
        OnClick = miNewAnalysisClick
      end
      object miSeparatorFile: TMenuItem
        Caption = '-'
      end
      object miClose: TMenuItem
        Caption = 'Close'
        OnClick = miCloseClick
      end
    end
    object miHelp: TMenuItem
      Caption = '?'
      object miAbout: TMenuItem
        Caption = 'About ...'
        OnClick = miAboutClick
      end
    end
  end
end
