{ config, pkgs, ... }:

{
  services.minecraft-servers = {
    enable = true;
    eula = true;
    openFirewall = true;

    servers.survival = {
      enable = true;
      package = pkgs.fabricServers.fabric-1_21_1;
      serverProperties = {
        server-port = 25565;
        white-list = true;
        hardcore = true;
        view-distance = 13;
      };
      whitelist = {
        "babyshark_13" = "f3b1b46a-d443-48b2-95d8-26a24e4e261a";
        "dannaal" = "632fb820-fe68-4b88-87d4-6d08a9de565b";
        "elaifren" = "41fe45cd-bef1-42dd-9f2f-6ea1e720e372";
      };
      symlinks = {
        "mods/HardcorePlus.jar" = pkgs.fetchurl {
          url = "https://cdn.modrinth.com/data/fWWnGrTh/versions/Ji6c2bjf/HardcorePlus%2B-1.3.0-fabric%2B1.21.1.jar";
          sha512 = "e067c6583c37f72269e860ef7c2f150dec35832105411e22b8ba207b2bb9973f6a494b850286101768d92138fad8fab4c07e53fa0b2d454d6096e5abf8559316";
        };
        "mods/fabric-api.jar" = pkgs.fetchurl {
          url = "https://cdn.modrinth.com/data/P7dR8mSH/versions/yGAe1owa/fabric-api-0.116.9%2B1.21.1.jar";
          sha512 = "e643876079b950aef9aad3eee8d27046305895e8d0f595f7f95010839adeaa25c55a6dc8624ccfba1201194d6598fcbc11f23a7a553ccefbb8c0ceacf388bb79";
        };
        "mods/Chunky.jar" = pkgs.fetchurl {
          url = "https://cdn.modrinth.com/data/fALzjamp/versions/RVFHfo1D/Chunky-Fabric-1.4.23.jar";
          sha512 = "02ca6af1ed31e9ebc51af20948a2afb670fe653c80aaeb990947caf6b655d6ab8eda3f1b64ef478633b67ef5d2fd0d1fe67e2107a4a522ef45fd1f183c9a6c9c";
        };
        "mods/lithium.jar" = pkgs.fetchurl {
          url = "https://cdn.modrinth.com/data/gvQqBUqZ/versions/XQJtuOTA/lithium-fabric-0.15.3%2Bmc1.21.1.jar";
          sha512 = "8c576d519121b0c2521101d2209eccd85d560b097fcb847aa54c51cd0d3f3947676f01c8d99913f514487c8e0972a1cf5f3da0c9ef0ec9bacdf2baeb4eb7d1a7";
        };
        "mods/ferritecore.jar" = pkgs.fetchurl {
          url = "https://cdn.modrinth.com/data/uXXizFIs/versions/sOzRw3CG/ferritecore-7.0.3-fabric.jar";
          sha512 = "3ad31620fac4ff44327dc7dedbe162b2d978f3f246dc16255a6e400ce9592a0d326fe36a626f3c1bf30a11f813093cbb4dcc107af039cff724d0cdf648541fdf";
        };
        "mods/c2me.jar" = pkgs.fetchurl {
          url = "https://cdn.modrinth.com/data/VSNURh3q/versions/DSqOVCaF/c2me-fabric-mc1.21.1-0.3.0%2Balpha.0.362.jar";
          sha512 = "8653a751eb2ad1ad70da38017ccad0ee2bda5448ffe405d28049f09a61936765303f63ba4fcff798f32bb1e6b4645e892c275515b69c98c1730e24caab0ba7e0";
        };
        "mods/krypton.jar" = pkgs.fetchurl {
          url = "https://cdn.modrinth.com/data/fQEb0iXm/versions/Acz3ttTp/krypton-0.2.8.jar";
          sha512 = "5f8cf96c79bfd4d893f1d70da582e62026bed36af49a7fa7b1e00fb6efb28d9ad6a1eec147020496b4fe38693d33fe6bfcd1eebbd93475612ee44290c2483784";
        };
        "mods/servercore.jar" = pkgs.fetchurl {
          url = "https://cdn.modrinth.com/data/4WWQxlQP/versions/wPZETsJM/servercore-fabric-1.5.5%2B1.21.1.jar";
          sha512 = "3566dbbc73e266b907fff2143bb8279783eecd5a9aa185afe0814919574dca18d61f4066e9ac184530f322f7ffa574b4d3240590742d27d9dfe6ea11f5d27478";
        };
        "mods/clumps.jar" = pkgs.fetchurl {
          url = "https://cdn.modrinth.com/data/Wnxd13zP/versions/3ene3W1l/Clumps-fabric-1.21.1-19.0.0.1.jar";
          sha512 = "0aa8e3508d0a40ef814d4064c0b6cadba6326128dd878fe69f30677c889cec4ccb8f639c22bdd7083a73ae8fa76e1c115b5e4b1885904dc1244b02ab2f728e78";
        };
        "mods/noisium.jar" = pkgs.fetchurl {
          url = "https://cdn.modrinth.com/data/KuNKN7d2/versions/4sGQgiu2/noisium-fabric-2.3.0%2Bmc1.21-1.21.1.jar";
          sha512 = "606ba78cf7f30d99e417c96aa042f600c1b626ed9c783919496d139de650013f1434fcf93545782e3889660322837ce6e85530d9e1a5cc20f9ad161357ede43e";
        };
        "mods/modernfix.jar" = pkgs.fetchurl {
          url = "https://cdn.modrinth.com/data/nmDcB62a/versions/NnNX8LBn/modernfix-fabric-5.25.1%2Bmc1.21.1.jar";
          sha512 = "dc67d6e023e1fcdeaf7837917c477cba212c611dfc2463c6ea021319c644087c79b477e0ea8194e113ddd7332fd5c6d82baa47c291eaac7f4a86252507b4e19f";
        };
      };
    };
  };
}
