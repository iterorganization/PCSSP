function Ke = pcssp_KCURR_Ke_tp()

Ketemp =            [7.5897    2.2463    0.6360    0.0716    0.0375    1.3650    0.4311    0.4682    0.2669    0.1481    0.1069;
                    2.2463    7.5965    2.7271    0.1620    0.0716    0.5997    0.3544    0.4922    0.3368    0.2156    0.1735;
                    0.6360    2.7271   19.7766    2.7271    0.6360    0.4134    0.4295    0.8765    0.8473    0.7833    0.8801;
                    0.0716    0.1620    2.7271    7.5964    2.2462    0.0790    0.1174    0.3320    0.4460    0.6465    1.2032;
                    0.0375    0.0716    0.6360    2.2462    7.5896    0.0483    0.0802    0.2590    0.4057    0.7950    2.4959;
                    1.3650    0.5997    0.4134    0.0790    0.0483    7.0413    1.1325    1.0079    0.4918    0.2431    0.1598;
                    0.4311    0.3544    0.4295    0.1174    0.0802    1.1325    4.7161    2.3927    1.0274    0.4710    0.2927;
                    0.4682    0.4922    0.8765    0.3320    0.2590    1.0079    2.3927   18.5566    4.5527    1.8379    1.0635;
                    0.2669    0.3368    0.8473    0.4460    0.4057    0.4918    1.0274    4.5527   15.6013    3.6070    1.8907;
                    0.1481    0.2156    0.7833    0.6465    0.7950    0.2431    0.4710    1.8379    3.6070   15.5583    4.9103;
                    0.1069    0.1735    0.8801    1.2032    2.4959    0.1598    0.2927    1.0635    1.8907    4.9103   23.8321];

Ke = Simulink.Parameter(Ketemp);

end