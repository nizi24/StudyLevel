//
//  RoleView.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/23.
//

import SwiftUI

struct RoleView: View {
    
    var body: some View {
        ScrollView {
            Group {
                Text("""
                この利用規約（以下，「本規約」といいます。）は，StudyLevelがこのウェブサイト上で提供するサービス（以下，「本サービス」といいます。）の利用条件を定めるものです。登録ユーザーの皆さま（以下，「ユーザー」といいます。）には，本規約に従って，本サービスをご利用いただきます。
                """)
                    .padding()
                    .font(.callout)
                Divider()
                Text("第１条（適応）")
                    .bold()
                Group {
                    Text("1. 本規約は，ユーザーとStudyLevelとの間の本サービスの利用に関わる一切の関係に適用されるものとします。")
                        .padding(.top)
                    Text("""
                    2. StudyLevelは本サービスに関し，本規約のほか，ご利用にあたってのルール等，各種の定め（以下，「個別規定」といいます。）をすることがあります。これら個別規定はその名称のいかんに関わらず，本規約の一部を構成するものとします。
                    """)
                    Text("3. 本規約の規定が前条の個別規定の規定と矛盾する場合には，個別規定において特段の定めなき限り，個別規定の規定が優先されるものとします。")
                }
                .padding(.horizontal)
                .padding(.bottom)
                Divider()
                Text("第２条（利用登録）")
                    .bold()
                Group {
                    Text("1. 登録希望者がStudyLevelの定める方法によって利用登録を申請し，StudyLevelがこれを承認することによって，利用登録が完了するものとします。")
                        .padding(.top)
                    Text("""
                        2. StudyLevelは，利用登録の申請者に以下の事由があると判断した場合，利用登録の申請を承認しないことがあり，その理由については一切の開示義務を負わないものとします
                    """)
                    Group {
                        Text("①. 利用登録の申請に際して虚偽の事項を届け出た場合")
                        Text("②. 本規約に違反したことがある者からの申請である場合")
                        Text("③. 未成年者，成年被後見人，被保佐人または被補助人のいずれかであり，法定代理人，後見人，保佐人または補助人の同意等を得ていなかった場合")
                        Text("""
                        ④. 反社会的勢力等（暴力団，暴力団員，右翼団体，反社会的勢力，その他これに準ずる者を意味します。）である，または資金提供その他を通じて反社会的勢力等の維持，運営もしくは経営に協力もしくは関与する等反社会的勢力との何らかの交流もしくは関与を行っているとStudyLevelが判断した場合
                        """)
                        Text("⑤. その他，StudyLevelが利用登録を相当でないと判断した場合")
                    }
                    .padding(.leading, 30)
                }
                .padding(.horizontal)
                .padding(.bottom)
                Divider()
                Text("第３条（ユーザーIDおよびパスワードの管理）")
                    .bold()
                Group {
                    Text("""
                        1. ユーザーは，自己の責任において，本サービスのユーザーIDおよびパスワードを管理するものとします。
                    """)
                        .padding(.top)
                    Text("""
                       2. ユーザーは，いかなる場合にも，ユーザーIDおよびパスワードを第三者に譲渡または貸与することはできません。StudyLevelは，ユーザーIDとパスワードの組み合わせが登録情報と一致してログインされた場合には，そのユーザーIDを登録しているユーザー自身による利用とみなします。
                    """)
                    Text("""
                        3. ユーザーID及びパスワードが第三者によって使用されたことによって生じた損害は，StudyLevelに故意又は重大な過失がある場合を除き，StudyLevelは一切の責任を負わないものとします。
                    """)
                }
                .padding(.horizontal)
                .padding(.bottom)
            }
            Group {
                Group {
                    Divider()
                    Text("第４条（利用料金および支払方法）")
                        .bold()
                    Group {
                        Text("""
                            1. ユーザーは，本サービスの有料部分の対価として，StudyLevelが別途定め，本ウェブサイトに表示する利用料金を，StudyLevelが指定する方法により支払うものとします。
                        """)
                            .padding(.top)
                        Text("""
                        2. ユーザーが利用料金の支払を遅滞した場合には，ユーザーは年14.6％の割合による遅延損害金を支払うものとします。
                        """)
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                    Divider()
                    Text("第５条（禁止事項）")
                        .bold()
                    Text("ユーザーは，本サービスの利用にあたり，以下の行為をしてはなりません。")
                        .padding()
                }
                Group {
                    Group {
                        HStack {
                            Text("1. 法令または公序良俗に違反する行為")
                                .padding(.top)
                            Spacer()
                        }
                        HStack {
                            Text("2. 犯罪行為に関連する行為")
                            Spacer()
                        }
                        HStack {
                            Text("3. StudyLevel，本サービスの他のユーザー，または第三者のサーバーまたはネットワークの機能を破壊したり，妨害したりする行為")
                            Spacer()
                        }
                        HStack {
                            Text("4. サービスの運営を妨害するおそれのある行為")
                            Spacer()
                        }
                        HStack {
                            Text("5. 他のユーザーに関する個人情報等を収集または蓄積する行為")
                            Spacer()
                        }
                        HStack {
                            Text("6. 不正アクセスをし，またはこれを試みる行為")
                            Spacer()
                        }
                        HStack {
                            Text("7. 他のユーザーに成りすます行為")
                            Spacer()
                        }
                        HStack {
                            Text("7. 他のユーザーに成りすます行為")
                            Spacer()
                        }
                        HStack {
                            Text("8. サービスに関連して，反社会的勢力に対して直接または間接に利益を供与する行為")
                            Spacer()
                        }
                        HStack {
                            Text("9. StudyLevel，本サービスの他のユーザーまたは第三者の知的財産権，肖像権，プライバシー，名誉その他の権利または利益を侵害する行為")
                            Spacer()
                        }
                    }
                    HStack {
                        Text("10. 以下の表現を含み，または含むとStudyLevelが判断する内容を本サービス上に投稿し，または送信する行為")
                        Spacer()
                    }
                    Group {
                        HStack {
                            Text("①. 過度に暴力的な表現")
                            Spacer()
                        }
                        HStack {
                            Text("②. 露骨な性的表現")
                            Spacer()
                        }
                        HStack {
                            Text("③. 人種，国籍，信条，性別，社会的身分，門地等による差別につながる表現")
                            Spacer()
                        }
                        HStack {
                            Text("④. 自殺，自傷行為，薬物乱用を誘引または助長する表現")
                            Spacer()
                        }
                        HStack {
                            Text("⑤. その他反社会的な内容を含み他人に不快感を与える表現")
                            Spacer()
                        }
                    }
                    .padding(.leading, 30)
                    HStack {
                        Text("11. 以下を目的とし，または目的とするとStudyLevelが判断する行為")
                        Spacer()
                    }
                    Group {
                        HStack {
                            Text("①. 営業，宣伝，広告，勧誘，その他営利を目的とする行為（StudyLevelの認めたものを除きます。）")
                            Spacer()
                        }
                        HStack {
                            Text("②. 性行為やわいせつな行為を目的とする行為")
                            Spacer()
                        }
                        HStack {
                            Text("③. 面識のない異性との出会いや交際を目的とする行為")
                            Spacer()
                        }
                        HStack {
                            Text("④. 他のユーザーに対する嫌がらせや誹謗中傷を目的とする行為")
                            Spacer()
                        }
                        HStack {
                            Text("⑤. StudyLevel，本サービスの他のユーザー，または第三者に不利益，損害または不快感を与えることを目的とする行為")
                            Spacer()
                        }
                        HStack {
                            Text("⑥. その他本サービスが予定している利用目的と異なる目的で本サービスを利用する行為")
                            Spacer()
                        }
                    }
                    .padding(.leading, 30)
                    HStack {
                        Text("12. 宗教活動または宗教団体への勧誘行為")
                        Spacer()
                    }
                    HStack {
                        Text("13. その他，StudyLevelが不適切と判断する行為")
                        Spacer()
                    }
                }
                .padding(.horizontal)
                .padding(.bottom)
                Group {
                    Divider()
                    Text("第６条（本サービスの提供の停止等）")
                    Text("""
                        1. StudyLevelは，以下のいずれかの事由があると判断した場合，ユーザーに事前に通知することなく本サービスの全部または一部の提供を停止または中断することができるものとします。
                    """)
                        .padding()
                    Group {
                        HStack {
                            Text("①. 本サービスにかかるコンピュータシステムの保守点検または更新を行う場合")
                            Spacer()
                        }
                        HStack {
                            Text("②. 地震，落雷，火災，停電または天災などの不可抗力により，本サービスの提供が困難となった場合")
                            Spacer()
                        }
                        HStack {
                            Text("③. コンピュータまたは通信回線等が事故により停止した場合")
                            Spacer()
                        }
                        HStack {
                            Text("④. その他，StudyLevelが本サービスの提供が困難と判断した場合")
                            Spacer()
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                    .padding(.leading, 30)
                    Text("""
                        2. StudyLevelは，本サービスの提供の停止または中断により，ユーザーまたは第三者が被ったいかなる不利益または損害についても，一切の責任を負わないものとします。
                    """)
                        .padding(.horizontal)
                        .padding(.bottom)
                }
                RoleLetterHalfView()
            }
        }
        .navigationBarTitle(Text("利用規約"), displayMode: .inline)
    }
}

struct RoleView_Previews: PreviewProvider {
    static var previews: some View {
        RoleView()
    }
}
