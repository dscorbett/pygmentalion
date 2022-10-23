#charset "utf-8"

// SPDX-License-Identifier: Apache-2.0 OR BSD-2-Clause

/*
Copyright 2014, 2022 David Corbett

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

/*
Copyright 2014, 2022 David Corbett

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are
met:

* Redistributions of source code must retain the above copyright
  notice, this list of conditions and the following disclaimer.

* Redistributions in binary form must reproduce the above copyright
  notice, this list of conditions and the following disclaimer in the
  documentation and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
"AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

#include <adv3.h>
#include <bignum.h>
#include <en_us.h>

extern function extern_function;
extern method extern_method;
extern function extern_function(a, b=a, c='<<a>>', d:, e:=1, f?, ...);
extern method extern_method(a, b=a, c='<<a>>', d:, e:=1, f?, [g]);;
extern class extern_class;
extern object extern_object;
intrinsic 't3vm' { };
#ifndef PropDefAny
intrinsic class Object 'root-object/030004' { };
#endif
object /**//**/ // /* \\
#define Room Unthing
    template [lst];

/*
 *   Quotations from "Le Roman de la Rose" are transcribed from MS. Douce 195,
 *   owned by Bodleian Library, University of Oxford
 *   (https://digital.bodleian.ox.ac.uk/objects/bb971cd2-a682-45e5-866f-31ce76482afe/).
 */

versionInfo: GameID
    IFID = '17D8EFC3-07DA-4DDE-A837-FF7C4E386A77'
    name = 'Pygmentalion'
    headline = 'An Interactive Romance'
    byline = 'by David Corbett'
    htmlByline = 'by <a href="mailto:corbett.dav\100northeastern.edu">David
        Corbett</a>'
    version = '1.1.0'
    authorEmail = 'David Corbett\040<corbett.dav\x40northeastern.edu>'
    desc = 'Colors gleam and fade as her wardrobe runs the gamut, but she
        remains pale and lifeless. Though she is a statue carved by your own
        hand, you love her more than anything. If only she could live and love
        you too.\\nPygmentalion is a short game originally designed to provide
        an example file for the syntax highlighter Pygments.'
    htmlDesc = 'Colors gleam and fade as her wardrobe runs the gamut, but she
        remains pale and lifeless. Though she is a statue carved by your own
        hand, you love her more than anything. If only she could live and love
        you too.<p><i>Pygmentalion</i> is a short game originally designed to
        provide an example file for the syntax highlighter <a
        href="https://pygments.org/">Pygments</a>.'
    firstPublished = '2014-10-08'
    forgivenessLevel = 'Merciful'
    gameUrl = 'http://github.com/dscorbett/pygmentalion'
    copyingRules = 'Other; Compilations Allowed'
    presentationProfile = 'Multimedia'
    showAbout()
    {
        "This is a short game originally designed to provide an example file
        for the syntax highlighter <<externalLink('https://pygments.org/',
        'Pygments')>>.\b
        Scattered throughout the game are highlighted words corresponding to
        syntactic token types. Finding them increases your score but is not
        necessary to beat the game. Some are easy to find, but these are the
        <<highlightToken('exception')>> rather than the rule. Many are hidden
        and some may become unavailable as the story progresses.\b
        The command CALCULATE may be abbreviated as C. For more commands, type
        <<aHref('help', 'HELP')>>.\b
        For hints, <<aHref('pray to Iris', 'PRAY TO IRIS')>>.
        <!-- For clues, ask Ariadne. -->";
    }
    showCredit() {
        "Credit goes to Pygments for providing the excuse to write this game.
        The story was loosely inspired by a section of <<iOrQ('Le Roman de la
        Rose')>>, quotations from which are transcribed from
        <<externalLink('https://digital.bodleian.ox.ac.uk/objects/<<
        >>bb971cd2-a682-45e5-866f-31ce76482afe/', 'MS. Douce 195')>>. The cover
        art is a modification of an image of MS. Douce 195, copyright 2019
        Bodleian Libraries, University of Oxford. ";
    }
;

/*
 *   Pymalıon fu ētaılleꝛꝛes.
 *   Poᷣtrayās en fus ⁊ en peꝛꝛeˢ
 *   En metaulx en os ⁊ en cyꝛes
 *   Et en touteˢ aultres matıres.
 *   Quon peult a tel oeuure trouuer.
 *   Poᷣ ſon grant engin eſpꝛouuer.
 *   Car maıſtre en fu bıen ꝺıre loz.
 *   Ainſı com poᷣ acquerre loz.
 *   Se voult a poᷣtraıre ꝺeẟuyꝛe.
 *   Sı fıſt vng ymage ꝺiuuyꝛe.
 *   Et miſt au faıre tel entente.
 *   Quel fu ſı plaıſāt et ſı gente.
 *   Quel ſembloıt eſtre auſſı viue.
 *   Com la plus belle rıens qͥ viue
 *      (MS. Douce 195, fol. 149r)
 */

gameMain: GameMainDef
    initialPlayerChar: Actor {
        vocabWords = 'Pygmentalion'
        desc
        {
            "Your calm exterior belies the tempestuous feelings within. You are
            currently <<feelings[rand_feeling_index_box_muller]>> ";
        }
        location = entrance
        rand_feeling_index_box_muller
        {
            local u1 = (rand(99) + 1) / 100.0;
            local u2 = rand(100) / 100.0;
            local std_dev = 6.0;
            local tolerance = 1.3;
            local magnitude = std_dev * (-2.0 * u1.logE()).sqrt();
            local mean = (feelings.length - 1 - tolerance * std_dev)
                * libScore.totalScore / gameMain.maxScore
                + 1 + std_dev * tolerance / 2;
            local z0 =
                magnitude * (BigNumber.getPi(3) * 2.0 * u2).cosine() + mean;
            return z0 < 1
                ? 1
                : z0 > feelings.length
                ? feelings.length
                : toInteger(z0);
        }
        feelings = [
            'angry at the uncaring Fates.',
            'bitter about how unfair everything is.',
            'feeling tormented.',
            'feeling harrowed by your tragic life.',
            'in a panic that she will never love you.',
            'in despair: she will never be able to love you.',
            'jealous. What if someone sneaks into the studio and she loves him
            instead?',
            'jealous. What if someone peeks through the window and sees her?',
            'feeling frustrated.',
            'dejected.',
            'in a blue funk.',
            'exhausted and drained.',
            'full of self-pity.',
            'pessimistic.',
            'lonely.',
            'racked with doubts.',
            'wincing at how desperate she must think you.',
            'uneasy.',
            'feeling sick of eating chopped liver every day.',
            'embarrassed about loving a statue.',
            'nervous about loving a living woman.',
            'wondering where you can find a woman who looks exactly like your
            statue.',
            'wondering how much longer you can buy such expensive gifts before
            your credit runs out.',
            'considering your plight with remote detachment.',
            'running through what-if scenarios.',
            'hoping a passing god might deign to metamorphose you into a
            statue.',
            'daydreaming about your most recent date.',
            'feeling tentatively hopeful.',
            'optimistic.',
            'learning that life is okay.',
            'daydreaming about your next date.',
            'brainstorming dress patterns.',
            'mentally composing an ode to her beauty.',
            'determined to make this relationship work.',
            'pleased with your progress so far.',
            'smiling, thinking of her pretty face.',
            'counting the ways you love her.',
            'planning your wedding.',
            'thinking about your future children.',
            'grateful to the benevolent eudaemons.',
            'feeling happy.',
            'giddy with excitement.',
            'euphoric due to infatuation.',
            'thinking about how much you love her.'
        ]
        dobjFor(GiveTo)
        {
            verify
            {
                if (gIobj == statue)
                    /*
                     *   Oꝛ ſuys par ceſte mal baıllys.
                     *   Par le meſt tout lı ſēs faıllys.
                     *   Las ꝺont me vint ceſte penſee.
                     *   Cōme fu telle amour bꝛaſcee.
                     *      (MS. Douce 195, fol. 149r–149v)
                     */
                    illogicalAlready('{You/He} {have} already given {yourself}
                        to {that iobj/her}. {You/He} {were} {its iobj/hers}
                        from the moment {you/he} first saw {that iobj/her}. ');
                else
                    nonObvious;
            }
        }
    }
    showIntro
    {
        /*
         *   Bıen le cuıẟay lācer de bout.
         *   Maıs ıl reſſoꝛt ⁊ ıe rebout.
         *   Ce rıēs ny vault touſıoᷣˢ recule.
         *   Ny pot entrer poᷣ choſe nulle.
         *   [...]
         *   Troys foız hurta.iij.foız faıllıt.
         *   Troys foız a ſa poꝛte aſſaıllıt.
         *   Troys foız ſaſſıſt en la vallee.
         *   Tout las poᷣ pꝛenꝺꝛe allenee.
         *      (MS. Douce 195, fol. 155r)
         */
        "Ivory&mdash; Horn&mdash; Ivory&mdash; You push on the gates separating
        you from your beloved, but they do not budge.
        <.p>Darkness&mdash; Light&mdash; Darkness&mdash; Colors gleam and fade
        as her wardrobe runs the gamut, but she remains pale and lifeless.
        Though she is a statue carved by your own hand, you love her more than
        anything. If only she could live and love you too.
        <.p>You pound again on the ivory gate, and as you do&mdash;
        <.p>You awake in your studio. Perhaps this is the day your prayers will
        be answered.\b
        <b><<versionInfo.name>></b>\n
        Copyright 2014, 2022 <<versionInfo.byline>>\n
        Version <<versionInfo.version>>\b
        <.notification>First-time players should type <<aHref('about',
        'ABOUT')>>. Those unfamiliar with interactive fiction in general should
        type <<aHref('help', 'HELP')>>. See also <<aHref('credits',
        'CREDITS')>>.<./notification>\b";
    }
    setAboutBox
    {
        "<aboutbox><center>
        <b><<versionInfo.name.toUpper()>></b>\b
        Version <<versionInfo.version>>\b
        Copyright 2014, 2022 <<versionInfo.byline>>
        </center></aboutbox>";
    }
;

enum token token, tokOp, token;

modify cmdTokenizer
    rules_ = static
    [
        ['whitespace', new RexPattern('%s+'), nil, &tokCvtSkip, nil],
        ['punctuation', new RexPattern('[.,;:?!]'), tokPunct, nil, nil],
        ['spelled number',
         new RexPattern('<NoCase>(twenty|thirty|forty|fifty|sixty|'
                        + 'seventy|eighty|ninety)-'
                        + '(one|two|three|four|five|six|seven|eight|nine)'
                        + '(?!<AlphaNum>)'),
         tokWord, &tokCvtSpelledNumber, nil],
        ['spelled operator', new RexPattern(
            '<NoCase>(plus|positive|minus|negat(iv)?e|not|inverse(%s+of)?|'
            + 'times|over|divided%s+by|mod(ulo)?|and|xor|or|[al]?sh[lr])'
            + '(?!<AlphaNum>)'),
         tokOp, &tokCvtSpelledOperator, nil],
        ['operator', R'[-!~+*/%&^|]|<<|>>>?', tokOp, nil, nil],
        ['x', R'[xX](?=%d)', tokWord, &tokCvtSpelledOperator, nil],
        ['word', new RexPattern('<Alpha|-|&><AlphaNum|-|&|squote>*'),
         tokWord, nil, nil],
        ['string ascii-quote', R"""<min>([`\'"])(.*)%1(?!<AlphaNum>)""",
         tokString, nil, nil],
        ['string back-quote', R"<min>`(.*)'(?!%w)", tokString, nil, nil],
        ['string curly single-quote', new RexPattern('<min>\u2018(.*)\u2019'),
         tokString, nil, nil],
        ['string curly double-quote', new RexPattern('<min>\u201C(.*)\u201D'),
         tokString, nil, nil],
        ['string unterminated', R'''([`\'"\u2018\u201C](.*)''', tokString,
         nil, nil],
        ['integer', new RexPattern('[0-9](,?[0-9]+)*'), tokInt, &tokCvtInt,
         nil]
    ]
    replace tokCvtSpelledOperator(txt, typ, toks)
    {
        toks.append([rexReplace(R'%s+', txt.toLower(), '\\'), typ, txt]);
    }
    tokCvtInt(txt, typ, toks)
    {
        toks.append([txt.findReplace(',', ''), typ, txt]);
    }
;

externalLink(href, txt)
{
    local linksHttp =
#ifdef TADS_INCLUDE_NET
        true
#else
        systemInfo(SysInfoLinksHttp) == 1
#endif
        ;
    if (linksHttp)
        return '<a href="<<href.htmlify>>" target=_blank><<txt>></a>';
    return '<<txt>> (<<href.htmlify>>)';
}

iOrQ(txt)
{
    local element = outputManager.htmlMode ? 'i' : 'q';
    return '\x3C<<element>>><<txt>></<<element>>>';
}

ul(plain, [items])
{
    local s = new StringBuffer;
    if (!outputManager.htmlMode)
        s.append('\b');
    s.append('<ul');
    if (plain)
        s.append(outputManager.htmlMode
            ? ' style="list-style-type: none"'
            : ' plain');
    s.append('>');
    for (local item in items)
    {
        if (!outputManager.htmlMode)
            s.append('\t');
        s.append('<li>');
        if (outputManager.htmlMode)
            s.append(item);
        else
        {
            s.append(
                rexReplace(['<li>', R'\b(?=<ul%b)', R'(?<=</ul>)\b'],
                item, ['\t%*', '\n']));
            s.append('\n');
        }
    }
    s.append('</ul>');
    if (!outputManager.htmlMode)
        s.append('\b');
    return toString(s);
}

/* Tokens */

/*
 *   Puiˢ li reueſt en maīteˢ guıſes.
 *   Robeˢ faıcteˢ ꝑ grāˢ maıſtrıſeˢ.
 *   De bıaulx ꝺꝛaps ẟe ſoye ⁊ ꝺe laīe.
 *   Deſcarlate ꝺe tıretaine.
 *   De vert ꝺe pers ⁊ ẟe bꝛunecte
 *   De couleᷣ freſche fine ⁊ necte.
 *   Ou moult a rıches paneˢ mıſes.
 *   Herminees vaıres et griſes
 *   Puis les lı roſte puis reſſaye.
 *   Cōmant lı ſıet robbe de ſaye
 *   Senꝺaulx meloguins galebꝛunˢ.
 *   Inꝺes vermeılz ıaunes ⁊ bꝛunˢ.
 *   [...]
 *   Aultre foız luy repꝛēẟ courage.
 *   De tout oſter ⁊ mectre guinꝺeˢ.
 *   Iaunes vermeılles vers ⁊ inꝺeˢ.
 *      (MS. Douce 195, fol. 150r)
 */

class Token: Achievement, InitObject
{
    points = 1;
    desc = "<<before_>><<desc_>><<after_>>";
    before = before = '', before_
    after = (after = '', after_)
#ifndef TADS_INCLUDE_NET
    execute()
    {
        local textColors = systemInfo(SysInfoTextColors);
        // Gargoyle falsely claims to support RGB, but it does not even support
        // swapping foreground and background colors.
        if (textColors == SysInfoTxcRGB
            && systemInfo(SysInfoOsName) == 'Gargoyle')
            textColors = SysInfoTxcNone;
        if (textColors != SysInfoTxcRGB)
        {
            if (textColors != SysInfoTxcNone && systemInfo(SysInfoBanners))
            {
                before_ = '<font color=bgcolor bgcolor=text>';
                after_ = '</font>';
            }
            else
            {
                // If banners are not supported, assume this is plain mode,
                // which falsely claims that `systemInfo(SysInfoTextColors) ==
                // SysInfoTxcAnsiFgBg`.
                before_ = '<b>[[';
                after_ = ']]</b>';
            }
        }
    }
#endif
}

Token template inherited 'before_' 'after_' 'desc_';

#define DoTokens \
    DoToken(builtin, '<font color=g&#x72;een>', '</font>') \
    DoToken(comment, '<i><font color=#408080>', '</font></i>') \
    DoToken(decorator, '<font color=#aa22ff>', '</font>') \
    DoToken(error, '<FONT COLOR=RED><U>', '</U></FONT>') \
    DoToken(escape, '<b><font color=#bb6622>', '</font></b>') \
    DoToken(exception, '<b><font color=#D2413A>', '</font></b>') \
    DoToken(float, '<u><font color=gray>', '</font></u>') \
    DoToken(keyword, \
        '<b><font face=TADS-Sans,sans-serif color=green>', '</font></b>') \
    DoToken(label, '<font color=#A0A000>', '</font>') \
    DoToken(long, '<i><font color=gray>', '</font></i>') \
    DoToken(name, '<u>', '</u>') \
    DoToken(number, '<font color=#666666>', '</font>') \
    DoToken(operator, '<b><font color=\"#AA22F&#x46\">', '</font></b>') \
    DoToken(string, '<font color=\'#BA212&#49\'>', '</font>') \
    DoToken(whitespace, \
        '''<font <<if systemInfo(SysInfoOsName) == 'Spatterlight'>> \
        color=white bgcolor=black \
        <<else>> \
        color="bgcolor"bgcolor=\'text\' \
        style="color: white; background-color: black" \
        <<end>>>''', '</font>') \

#define DoToken(name, before, after) name##Token: Token before after #@name;
DoTokens
#undef DoToken
#define DoToken(name, before, after) #@name -> name##Token,

highlightTokenOutputFilter: OutputFilter, InitObject
    tagPattern = R'<nocase><langle>!token<rangle>(.*?)<langle>!/token<rangle>'
    tokenMap = [
        DoTokens
        * -> nil
    ]
    execute
    {
        mainOutputStream.addOutputFilter(self);
    }
    filterText(ostr, val)
    {
        local match;
        local index = 1;
        while ((match = rexSearch(tagPattern, val, index)) != nil)
        {
            local inputTokenString = rexGroup(1)[3];
            local outputTokenString;
            local token = tokenMap[
                rexReplace(R'<^AlphaNum>+', inputTokenString.toLower(), '')];
            if (!token)
                outputTokenString = inputTokenString;
            else
            {
                token.awardPointsOnce();
                outputTokenString =
                    '<<token.before>><<inputTokenString>><<token.after>>';
            }
            local val0 = val.substr(1, match[1] - 1) + outputTokenString;
            index = val0.length() + 1;
            val = val0 + val.substr(match[1] + match[2]);
        }
        return val;
    }
;

function highlightToken(tokenString)
{
    return '<!token><<tokenString>><!/token>';
}

string /**//**/ // /* \\
#define Room Unthing
    template <<highlight *>> highlightToken;

/* Grammar for materials */

dictionary property materialWord;
grammar adjWord(materialWord): <materialWord materialWord>->adj_
    : AdjPhraseWithVocab
    getVocabMatchList(resolver, results, extraFlags)
    {
        return getWordMatches(adj_, &materialWord, resolver, extraFlags,
                              VocabTruncated);
    }
    getAdjustedTokens()
    {
        return [adj_, &materialWord];
    }
;

/* Rooms and objects */

+ property location;

entrance: Room 'Studio Entrance'
    "Your studio is where you create great works of art, though you have made
    nothing since you carved that statue. This corner, which now serves as your
    bedroom and dining room, is the entrance to the building. A door leads
    outside, and the studio itself is to the north and the east. "
    north = workbenchRoom
    northeast = sinkRoom
    east = altarRoom
    south = door
    out asExit(south)
    roomParts = (roomParts = inherited() - [defaultNorthWall, defaultEastWall])
;

+ door: LockableWithKey, Door 'door' 'door'
    "It is a simple wooden door. "
    materialWord = 'wood' 'wooden'
    keyList = [key]
    cannotOpenLockedMsg = '{The dobj/He} {is} locked. <<first time>>In {your}
        distracted state, {you/he} must have misplaced the key. <<only>>You
        cannot <<highlight 'escape'>>!<<breakingWouldBeUseful = true, nil>> '
;

+ campBed: Bed '(camp) bed' 'camp bed'
    "It is a narrow portable camp bed. You brought it into the studio so you
    would not have to leave the statue every night. "
    bulk = 10
;

+ endTable: Surface 'end table*tables' 'end table'
    "A small portable table. "
    bulk = 10
;

++ coinBox: OpenableContainer, RestrictedContainer
    '(coin) box/pyx/pyxis' 'coin box'
    "A small round box in which you keep your coins, when you have any. "
    bulk = 5
    iobjFor(PutIn) {
        check
        {
            failCheck('{You/He} {can} only put coins in the coin box. ');
        }
    }
    lookInDesc_ = 'empty. Maybe next time {you/he} check{s}, {it dobj/he} will
        contain a coin. {You/He} can only hope'
    lookInDesc = "\^<<itIsContraction>> <<lookInDesc_>>. "
    openStatus
    {
        return isOpen ? '<<inherited>> and <<lookInDesc_>>' : inherited;
    }
;

++ wineBottle: Thing 'bottle' 'bottle of wine'
    "A bottle of sea-dark wine. "
    materialWord = 'dark' 'sea' 'sea-dark' 'seadark' 'wine'
    aNameObjShort = (aNameFrom('bottle'))
    getFacets() { return [seawaterBottle]; }
    bulk = (getFacets()[1].bulk)
    dobjFor(Taste)
    {
        action
        {
            local loc = location;
            "{You/He} take{s} a sip and realize that this is not sea-dark wine
            after all. It is just seawater. ";
            moveInto(nil);
            seawaterBottle.moveInto(loc);
        }
    }
    dobjFor(Drink) remapTo(Taste, DirectObject)
    dobjFor(Pour)
    {
        verify
        {
            illogical('That would be wasteful. ');
        }
    }
    dobjFor(PourInto) remapTo(Pour, DirectObject)
    dobjFor(PourOnto) remapTo(Pour, DirectObject)
;

++ plateOfLiver: Food 'chopped liver plate' 'plate of chopped liver'
    "You have been living on chopped liver since you moved into the studio
    permanently. It isn&rsquo;t bad, but it does get monotonous. "
    getFacets() { return [plate]; }
    bulk = (getFacets()[1].bulk)
    dobjFor(Eat)
    {
        preCond = []
        action
        {
            local loc = location;
            "{You/He} eat{s} all the liver. The plate will be full again
            tomorrow morning though. Somehow, the liver always regenerates
            overnight. ";
            moveInto(nil);
            plate.moveInto(loc);
        }
    }
;

seawaterBottle: Thing 'bottle' 'bottle of seawater'
    "A bottle of wine-dark seawater. "
    materialWord = 'dark' 'sea' 'seawater' 'water' 'wine-dark' 'winedark'
    aNameObjShort = (aNameFrom('bottle'))
    bulk = 5
    dobjFor(Taste)
    {
        action
        {
            "{It dobj/He} taste{s} salty. ";
        }
    }
    dobjFor(Drink)
    {
        preCond = []
        verify { }
        check
        {
            failCheck('That would be disgusting. ');
        }
    }
    dobjFor(Pour)
    {
        verify
        {
            illogical('That would be wasteful. ');
        }
    }
    dobjFor(PourInto) remapTo(Pour, DirectObject)
    dobjFor(PourOnto) remapTo(Pour, DirectObject)
;

plate: Thing 'plate' 'plate'
    "It is empty for now. "
    bulk = 5
;

key: PresentLater, Key
    '(door) clean grime grimy key/tool*keys tools' 'bronze key' @altar
    "It is a <<unless clean>>grimy<<end>> bronze key. <<if clean>>On it is \
    etched the word <q><<keyword>></q>. "
    materialWord = 'bronze' 'metal'
    clean = nil
    keyword = (keyword = greekWordGenerator.generate(), targetprop)
    getState = (clean ? cleanState : grimyState)
    allStates = [cleanState, grimyState]
    dobjFor(CleanWith)
    {
        action
        {
            clean = true;
            "{You/He} clean{s} {the dobj/him}, revealing an inscription. ";
        }
    }
;

grimyState: ThingState
    stateTokens = ['grime', 'grimy']
;

cleanState: ThingState
    stateTokens = ['clean']
;

workbenchRoom: Room 'At the Workbench'
    "This workbench, in the northwest part of the studio, was where you would
    create works of art. Now you just come here to contemplate your
    creation&rsquo;s beauty, dress her up, ply her with gifts, and lament your
    hopeless situation.\b
    <<if gActor.setHer(statue)>><<end>>
    The statue stands on a plinth beside the workbench. "
    east = sinkRoom
    southeast = altarRoom
    south = entrance
    roomParts = (roomParts = inherited() - [defaultEastWall, defaultSouthWall])
    getDestName(actor, origin) { return 'the workbench'; }
;

+ chair: Chair 'diphros folding chair/okladias/stool' 'stool'
    "A portable folding stool, or diphros okladias. "
    bulk = 10
;

+ workbench: Chair, Fixture
    'bench/workbench' 'workbench'
    "Your workbench is usually scattered with tools and materials and
    half-finished projects. "
    descContentsLister: surfaceDescContentsLister
    {
        showListPrefixWide(itemCount, pov, parent)
        {
            "\b";
            inherited(itemCount, pov, parent);
        }
    }
    obviousPostures = []
;

++ chisel: Thing 'chisel/tool*tools' 'chisel'
    "A sharp tool used for carving. "
    dobjFor(Attack)
    {
        check
        {
            failCheck('{You/He} {is}n&rsquo;t in the mood for carving anything.
                ');
        }
    }
    dobjFor(AttackWith)
    {
        action { replaceAction(Attack, gDobj); }
    }
;

/*
 *   Dune aguılle bıen afılee.
 *   Dargent ẟe fıl ꝺoꝛ enfılee.
 *   Lı a pour mieulx eſtˢ veſtue.
 *   Chūne manche eſtroıt couſue.
 *      (MS. Douce 195, fol. 150v)
 */

++ needle: Thing 'needle/tool*tools' 'needle'
    "A sharp tool used for sewing. It is made of silver. "
    materialWord = 'metal' 'silver'
;

/*
 *   Anneletz ẟoꝛ es ẟoız lı boute.
 *      (MS. Douce 195, fol. 150v)
 */

++ goldNugget: Thing '(large) nugget' 'gold nugget'
    "It is a large nugget of gold that sparkles in the light. You haven&rsquo;t
    decided what to make it into yet. "
    materialWord = 'gold' 'golden' 'metal'
;

++ idol: Thing '(aphrodite) (cytherea) (venus) idol/statuette' 'idol'
    "The idol is a small statuette of Aphrodite carved from meerschaum. "
    materialWord = 'meerschaum' 'sepiolite'
    bulk = 5
    dobjFor(PrayTo) remapTo(PrayTo, aphrodite)
;

+ plinth: Fixture, Thing 'plinth/pedestal' 'plinth'
    "It&rsquo;s a smoothed block of marble half a cubit high. "
    materialWord = 'marble'
    contentsListedInExamine = nil
;

replace grammar predicate(Screw): ' ': object;
replace grammar predicate(ScrewWith): ' ': object;
replace grammar predicate(Unscrew): ' ': object;
replace grammar predicate(UnscrewWith): ' ': object;
// You're not Archimedes.

+ + statue: Fixture, Surface
    '(flawless) (milk-white) "creation\'s" \
    beauty/carving/creation/galatea/statue/woman' 'statue'
    "This is a<<if nameToken.scoreCount>>n untitled<<end>> statue of a
    <<if exceptionToken.scoreCount>>beautiful<<end>> woman carved from
    <<if errorToken.scoreCount>>flawless <<end>>
    <<if whitespaceToken.scoreCount>>milk-white <<end>>ivory.
    <<if escapeToken.scoreCount || longToken.scoreCount>>Her
    <<if longToken.scoreCount>>long <<end>>hair is done up in a
    chignon<<if escapeToken.scoreCount>>, with a few strands falling down her
    neck<<end>><<if floatToken.scoreCount>>, and \v<<else>>. <<end>><<end>>
    <<if floatToken.scoreCount>>She radiates an aura of contrapposto grace.
    <<end>><.p><<if labelToken.scoreCount || keywordToken.scoreCount ||
    decoratorToken.scoreCount || operatorToken.scoreCount ||
    builtinToken.scoreCount || commentToken.scoreCount>>You wonder what she
    <<if labelToken.scoreCount>>is going to<<else if
    keywordToken.scoreCount>>will<<else>>would<<end>> be like as a living
    woman. <<if decoratorToken.scoreCount>>Maybe she&rsquo;<<if
    keywordToken.scoreCount>>ll<<else>>d<<end>> be a painter and expand your
    business. <<end>>
    <<if operatorToken.scoreCount>>Maybe she&rsquo;<<if
    keywordToken.scoreCount>>ll<<else>>d<<end>> have a head for figures and
    <<if keywordToken.scoreCount>>will<<else>>would<<end>> put the accounts in
    order. <<end>>
    <<if builtinToken.scoreCount>>She&rsquo;<<if
    keywordToken.scoreCount>>ll<<else>>d<<end>> love you, obviously, but beyond
    that you don&rsquo;t know. <<else>>Who knows? You can only dream. <<end>>
    <<if commentToken.scoreCount>>If only Aphrodite would bring her to life
    without this silly puzzle about tokens and mirrors! <<end>>
    <<end>><.p><<if !contentsListedInExamine>>She is wearing
    <<buildSynthParam('a/him', contents[1])>>. "
    materialWord = 'ivory'
    contentsListedInExamine =
        (contents.length() != 1 || contents[1] != necklace)
    propertyset 'is*'
    {
        propertyset 'H*'
        {
            im = nil\
            er = true;
        }
        It = true
    }
    dobjFor(Kiss)
    {
        check
        {
            /*
             *   Car quāt ıe me vueıl a aıſıer.
             *   Et ꝺacoller et ꝺe baıſıer.
             *   Ie truis mamye autreſſı roıẟe.
             *   Cōme eſt.ı.pel et auſſı froıꝺe.
             *   Car quāt poᷣ la baıſıer y touche.
             *   Toute me refroıꝺıſt la bouche.
             *   Ha trop ay parle follemāt.
             *   Mercy ꝺoulce amye ē ꝺemāẟ.
             *      (MS. Douce 195, fol. 149v)
             */
            failCheck('{The dobj/She} {is} as stiff and cold as a post,
                {you/he} know{s} from experience. It would be more satisfying
                if {it dobj/she} were alive. Sorry, but it&rsquo;s true. ');
        }
    }
    dobjFor(Hug)
    {
        preCond = [actorStanding]
        action
        {
            /*
             *   Souef a ſes maīs la detaſte.
             *   Et croıt aınſı ꝯ ſe fuſt paſte.
             *   Que ce ſoıt ſa char quı lı fuye.
             *   Maiˢ ceſt ſa main qͥl y appuye.
             *      (MS. Douce 195, fol. 150r)
             */
            "<<one of>>{You/He} hold{s} {the dobj/her} in {your} arms.
            The ivory is cold, but as {you/he} linger{s} in a loving
            embrace, {you/he} notice{s} {its dobj/her} hand feels different: it
            has the warmth and softness of real flesh.
            <<if keywordToken.scoreCount>>Aphrodite did it! <<end>>
            {The dobj/She} {is} finally coming to life!
            <.p>Oh. That was just {your} own hand. Never mind.
            <<or>>{The dobj/She} {is} as stiff and cold as a post.
            <<stopping>>";
        }
    }
    dobjFor(Feel) remapTo(Hug, DirectObject)
    dobjFor(TalkTo)
    {
        verify { }
        action
        {
            /*
             *   Car nentenꝺ rıēs ne ne ſent.
             *      (MS. Douce 195, fol. 150r)
             */
            "{You/He} break{s} the silence but hear{s} nothing back. {You/He}
            {does}n&rsquo;t know what {you/he} {was} expecting; {it dobj/she}
            never answer{s} {you/him}. ";
        }
    }
    dobjFor(AskAbout) remapTo(TalkTo, DirectObject)
    dobjFor(AskFor) remapTo(TalkTo, DirectObject)
    dobjFor(TellAbout) remapTo(TalkTo, DirectObject)
    iobjFor(ShowTo)
    {
        verify { }
        action
        {
            /*
             *   Car de tāt com voꝰ me daıgnıez.
             *   Doulcemāt regarder et rıre.
             *   (MS. Douce 195, fol. 149v)
             */
            "{The iobj/She} stare{s} straight ahead with a smile on her lips.
            ";
        }
    }
    acceptCommand(issuingActor)
    {
        replaceAction(TalkTo, self);
        return nil;
    }
    afterAction
    {
        if (gActionIs(Yell))
            "\^<<nameDoes>> not appear to hear {you/him} screaming. ";
    }
    iobjFor(PutOn)
    {
        check
        {
            if (gDobj not /**//**/ // /* \\
#define Room Unthing
                in (necklace, __objref(necklace, warn)))
                failCheck(
                    'What would {it iobj/she} want with {that dobj/him}? ');
            inherited();
        }
    }
    iobjFor(GiveTo) {
        verify { nonObvious; }
        action {
            replaceAction(PutOn, gDobj, gIobj);
        }
    }
    dobjFor(Attack)
    {
        check
        {
            /*
             *   Ainſı pymalıon eſtriue.
             *   En ſon eſtrif na fōs ne riue.
             *   En vng eſtat poīt ne ẟemeure.
             *   Oꝛ ayme oꝛ haıt oꝛ rıt oꝛ pleure.
             *   Oꝛ eſt lıez oꝛ a meſaıſe.
             *   Oꝛ ſe toꝛmēte oꝛ rappaıſe.
             *      (MS. Douce 195, fol. 150r)
             */
            failCheck('Where did that thought come from? Even in the worst of
                {your} mood swings, {you/he} {have} never considered harming
                {that dobj/her}. ');
        }
    }
    dobjFor(AttackWith) remapTo(Attack, DirectObject)
    dobjFor(Break) remapTo(Attack, DirectObject)
    dobjFor(Taste) remapTo(Eat, DirectObject)
    iobjFor(ThrowAt) remapTo(Attack, IndirectObject)
;

/*
 *   Et treſſons gentılz et greſles.
 *   De ſoye vert a menuz perles.
 *      (MS. Douce 195, fol. 150r)
 */

+++ necklace: Wearable
    '(fine) (seed) pearl necklace/string pearls'
    '<<highlight 'string'>> of pearls<<gActor.setHasSeen(self)>>'
    "This necklace of countless fine seed pearls is the latest ornament with
    which you have adorned the statue, the latest attempt to express your
    feelings through gifts. "
    initDesc = "You put this pearl necklace on the statue yesterday. "
    canMatchThem = true
    hideFromAll(action) { return !seen; }
    hideFromDefault(action) { return !seen; }
    suppressAutoSeen = true
;

altarRoom: Room 'At the Altar'
    "Light from the window illuminates a crude altar. Until recently, this area
    was the gallery where customers would buy your art; all that is gone now.
    The rest of the studio lies north and west. "
    north = sinkRoom
    northwest = workbenchRoom
    west = entrance
    roomParts = (roomParts = inherited() - [defaultNorthWall, defaultWestWall])
    getDestName(actor, origin) { return 'the altar'; }
;

+ window: Fixture 'window' 'window'
    "It&rsquo;s just a window above the altar. <<one of>>The space under the
    window is blank; as an interior <<highlight 'decorator'>>, you can&rsquo;t
    help but think the wall would benefit from a bas-relief, but &ndash;
    <i>sigh</i> &ndash; you are too lovelorn to wield the chisel. <<||>>The
    wall right below it is a boring <<highlight 'white space'>>. <<stopping>>"
;

/*
 *   Quauſſı es tu moult coᷣꝛoucıee.
 *   Quāt chaſtete eſt exaucıee.
 *   Se ıay grāt peine deſſeruıe.
 *   De ce q̄ ıe lay tant ſeruie.
 *      (MS. Douce 195, fol. 151r)
 */

+ cage: KeyedContainer 'cage' 'wicker cage'
    "A knee-high wicker cage with an iron padlock. "
    materialWord = 'wicker'
    keyList = [cageKey]
    lockStatusObvious = true
    maxSingleBulk = 5
    maxSingleBulkWhenClosed = 1
    material = coarseMesh
    isListed = (!net.isInInitState)
    canFitObjThruOpening(obj)
    {
        return inherited(obj)
            && (isOpen || obj.getBulk() <= maxSingleBulkWhenClosed);
    }
    checkMoveViaPath(obj, dest, op)
    {
        return op is in (PathIn, PathOut) && !isOpen
            && canFitObjThruOpening(obj)
            ? checkStatusSuccess
            : inherited(obj, dest, op);
    }
    iobjFor(PutIn)
    {
        preCond
        {
            local lst = inherited();
            if (gTentativeDobj.indexWhich({x:
                    local bulk = x.obj_.getBulk(),
                    bulk != nil && bulk > maxSingleBulkWhenClosed
                }) == nil)
                lst -= objOpen;
            return lst;
        }
        check
        {
            if (isLocked && gDobj != net && knownKeyList.indexWhich(
                {x: !x.isOrIsIn(gDobj) && gActor.canTouch(x)}) == nil)
            {
                gActor.setPronounObj(self);
                local dobjBulk = gDobj.getBulk();
                failCheck('{The iobj/He} is locked. <<if dobjBulk <=
                    maxSingleBulkWhenClosed && gDobj.isIn(gActor)>>{You/He}
                    could slip {the dobj/him} through the bars, but {you/he}
                    might not be able to get {it dobj/him} back out again. ');
            }
            inherited();
        }
        action
        {
            inherited();
            if (gDobj == net)
                "{You/He} slip{s} <<theNameFrom(net.bagName)>> of {the
                dobj/him} between the bars. \^<<theNameFrom(net.poleName)>> of
                {the dobj/him} is too long to fit inside {the iobj/him}, so it
                sticks out<<if net.isInInitState>>, touching the wall<<end>>.
                ";
            else if (!isOpen)
                "{The dobj/He} fit{s} through the bars. ";
        }
    }
;

++ padlock: LockableWithKey, Component 'lock/padlock' 'padlock'
    "An unbreakable iron padlock. "
    materialWord = 'iron' 'metal'
    lockStatusObvious = true
    examineStatus { return delegated Lockable; }
    keyList = (location.keyList)
    knownKeyList = (location.knownKeyList)
    isLocked = (location.isLocked)
    dobjFor(Lock) remapTo(Lock, location)
    dobjFor(LockWith) remapTo(LockWith, location, IndirectObject)
    dobjFor(Unlock) remapTo(Unlock, location)
    dobjFor(UnlockWith) remapTo(UnlockWith, location, IndirectObject)
    dobjFor(Break)
    {
        preCond = inherited() - touchObj
        verify() { nonObvious; }
        check
        {
            failCheck('{That dobj/He} might as well be made of adamant for all
                {you/he} could do to break it. ');
        }
    }
;

/*
 *   Et poꝛte o moy par grāt ꝯfoꝛt.
 *   Eſcharpe ⁊ bourꝺon bon ⁊ foꝛt
 *   Tel qͥl na meſtıer ꝺe ferrer
 *   Poᷣ ıournoyer ne pour eꝛꝛer
 *   Leſcharpe eſt ꝺe bōne faıcture.
 *   Dune pel ſoupple ſās couſture.
 *      (MS. Douce 195, fol. 153v)
 */

++ net: Container
    '(butterfly) (pool) walking
    bag/pack/pole/net/quarterstaff/rod/sack/satchel/staff/stick/tool*tools'
    desc = "It is a <<highlight 'long'>> wooden pole with
    <<aNameFrom(bagName)>> attached to <<if location == cage>>the end inside
    <<location.theName>><<else>>one end<<end>>. This versatile tool be used as
    a quarterstaff, butterfly net, pool net, or walking stick. "
    materialWord = 'wood' 'wooden'
    initSpecialDesc = "\^<<if bagMentioned>><<theNameFrom(poleName)>> of
    <<end>><<aName>> sticks out <<if gActionIs(Examine)>>through the
    bars<<else>>of <<location.aName>><<end>> and leans ithyphallically against
    the wall. "
    isInInitState
    {
        if (location != cage || !cage.location.ofKind(Room))
            return nil;
        for (local wall = firstObj(DefaultWall);
            wall != nil;
            wall = nextObj(wall, DefaultWall))
        {
            if (cage.canTouch(wall))
                return true;
        }
        return nil;
    }
    useSpecialDescInContents(cont)
    {
        return cont == cage && isInInitState
            && contents.valWhich({x:
                x.isListedInContents && (!x.ofKind(Hidden) || x.discovered)
            }) == nil;
    }
    bagMentioned = nil
    poleName = 'pole'
    bagName = (bagMentioned = true, bagName = 'bag')
    name = (gActionIn(LookIn, Search) && gDobj == self
        ? bagName
        : bagMentioned
        ? 'net'
        : poleName)
    maxSingleBulk = 5
    dobjFor(Examine)
    {
        action
        {
            inherited();
            if (canBeTouchedBy(gActor))
            {
                local discovered = [];
                for (local item in contents)
                {
                    if (item.ofKind(Hidden) && !item.discovered)
                    {
                        item.discover();
                        discovered += item;
                    }
                }
                if (discovered.length)
                    "<.p>In <<theNameFrom(bagName)>>, {you/he} find{s}
                    <<objectLister.showSimpleList(discovered)>>. ";
            }
            else
            {
                for (local item in contents)
                {
                    if (item.ofKind(Hidden) && !item.discovered
                        && item.bulk >= maxSingleBulk)
                    {
                        "There is something bulky in <<theNameFrom(bagName)>>,
                        but {you/he} {can't} see what it is. ";
                        break;
                    }
                }
            }
        }
    }
    isHidden(obj) { return obj.ofKind(Hidden) && !obj.discovered; }
    firstBulkyItem = (contents
        .sort(SortAsc, {x, y:
            toInteger(isHidden(x)) - toInteger(isHidden(y))
        }).valWhich({x: x.bulk >= maxSingleBulk}))
    dobjFor(Take)
    {
        preCond = (inherited() - (isIn(cage) ? touchObj : []))
        verify
        {
            if (!isIn(cage))
                inherited();
        }
        action
        {
            if (isIn(cage))
            {
                local bulkyItem = firstBulkyItem;
                if (bulkyItem)
                {
                    cage.breakingWouldBeUseful = true;
                    local preamble = bagMentioned ? ''
                        : '{You/He} tr{ies} to remove <<theName>> from
                        <<cage.theName>>, but there is <<aNameFrom(bagName)>>
                        attached to the end inside, and \v';
                    if (isHidden(bulkyItem) || !cage.isOpen)
                        reportFailure('<<preamble>>Something in
                            <<theNameFrom(bagName)>> is too big to fit through
                            the bars. ');
                    else
                        reportFailure('<<preamble>>The <<bulkyItem.name>> is
                            too big for <<theNameFrom(bagName)>> to fit through
                            the bars. ');
                    return;
                }
                /*
                 *   Poᷣ ce que chaſtete laıſſoit
                 *      (MS. Douce 195, fol. 151v)
                 */
                "{The dobj/He} slip{s} through the bars. ";
            }
            inherited();
        }
    }
    dobjFor(PutIn)
    {
        check
        {
            inherited();
            if (gIobj == cage)
            {
                local bulkyItem = firstBulkyItem;
                if (bulkyItem)
                {
                    if (isHidden(bulkyItem))
                        failCheck('Something bulky in <<theNameFrom(bagName)>>
                            prevents putting it in. ');
                    else
                        failCheck('The bulky <<bulkyItem.name>> in
                            <<theNameFrom(bagName)>> prevents putting it in.
                            ');
                }
            }
        }
    }
    iobjFor(PutIn)
    {
        preCond = (inherited() + (gDobj == bird ? objHeld : []))
    }
    lookInDesc
    {
        if (!bagMentioned)
            mainReport('At one end of <<theNameFrom(poleName)>> is
                <<aNameFrom(bagName)>>. ');
    }
    dobjFor(LookIn)
    {
        preCond = (inherited() + touchObj)
    }
;

modify Thing
    dobjFor(Take)
    {
        check
        {
            if (net.isIn(self))
                failCheck('\^<<net.nameIs>> too unwieldy. {You/He}&rsquo;ll
                    have to remove <<net.itObj>> from <<net.location.theName>>
                    first. ');
            inherited();
        }
    }
    checkPut
    {
        if (isHeldBy(gActor) && gDobj == net)
            failCheck('{The dobj/He} {is} too unwieldy. {You/He}&rsquo;ll have
                to put {the iobj/him} down first. ');
    }
    iobjFor(PutIn)
    {
        check
        {
            checkPut();
            inherited();
        }
    }
    iobjFor(PutOn)
    {
        check
        {
            checkPut();
            inherited();
        }
    }
;

/*
 *   Maıˢ ſachez q̄lle neſt paˢ vuyẟe.
 *   Deux marteletz ꝑ grāt eſtuyẟe.
 *   Y mıſt ꝺeꝺās ſı com moy ſēble.
 *   Dılıgēmant ⁊ tous enſemble.
 *   Nature quı les me baılla.
 *      (MS. Douce 195, fol. 153v)
 */

class Hammer: Thing
    iobjFor(AttackWith)
    {
        preCond = [objHeld]
        verify() { }
    }
;

+++ ballPeenHammer: Hammer, Hidden
    'ball ball-peen ballpeen peen peening hammer/tool*hammers tools'
    'ball-peen hammer'
    "A hammer used for hardening metal. "
    materialWord = 'metal' 'steel'
    bulk = 5
;

+++ mallet: Hammer, Hidden 'hammer/mallet/tool*hammers tools' 'mallet'
    "A wooden hammer with a large head, used to strike a chisel. "
    materialWord = 'wood' 'wooden'
    bulk = 5
;

+ altar: Bed, Fixture 'crude rough altar/banker/slab' 'altar'
    "A rough marble slab lies on a granite banker. In your rush to construct an
    altar, you neglected the usual surface finish and friezes, but you pray at
    it anyway. You are sure the gods will understand. "
    materialWord = 'granite' 'marble' 'stone'
    obviousPostures = []
    descContentsLister: surfaceDescContentsLister
    {
        showListPrefixWide(itemCount, pov, parent)
        {
            "\b";
            inherited(itemCount, pov, parent);
        }
    }
    dobjFor(Pray) { verify { } }
    dobjFor(PrayTo)
    {
        verify
        {
            illogical('{subj actor}Praying to {the dobj/him} would make the
                gods jealous. (Praying <em>at</em> the altar would be fine.)
                ');
        }
    }
    dobjFor(PrayAt) remapTo(PrayToAt, aphrodite, DirectObject)
    iobjFor(PrayToAt) {
        preCond = [actorNotInObj]
        verify { }
    }
    iobjFor(GiveTo) {
        verify { nonObvious; }
        action {
            replaceAction(PutOn, gDobj, gIobj);
        }
    }
    iobjFor(PutOn)
    {
        preCond = inherited() + objEmpty
    }
;

actorNotInObj: PreCondition
    checkPreCondition(obj, allowImplicit)
    {
        if (obj == nil || !gActor.isIn(obj))
            return nil;
        if (allowImplicit && tryImplicitAction(GetOutOf, obj))
        {
            if (gActor.isIn(obj))
                exit;
            return true;
        }
        reportFailure('{You/He} {must} get <<obj.actorOutOfPrep>>
            <<obj.theName>> before {you/he} can do that. ');
        exit;
    }
;

class Deity: Unthing
    notHereMsg = 'A deity can only be interacted with through prayer. '
    dobjFor(PrayTo)
    {
        verify { }
        check
        {
            if (!gActor.canSee(altar))
                failCheck('You need an altar to interact with a deity. ');
        }
        remap = (gActor.canSee(altar)
            ? [PrayToAtAction, DirectObject, altar]
            : inherited())
    }
    dobjFor(PrayAt) remapTo(PrayTo, DirectObject)
    dobjFor(PrayToAt)
    {
        verify { }
        check
        {
            if (!gActor.canSee(altar))
                failCheck('You need an altar to interact with a deity. ');
        }
    }
    iobjFor(PrayToAt)
    {
        verify
        {
            illogical('{The iobj/She} would not like to be prayed at as if {it
                iobj/she} were an altar. ');
        }
    }
;

aphrodite: Deity
    '(love) aphrodite/cytherea/deity/god/goddess/venus love' 'Aphrodite'
    location = (gPlayerChar)
    isProperName = true
    isHer = true
    iobjFor(GiveTo)
    {
        verify
        {
            if (gActor.canSee(altar) && gDobj == gActor)
                nonObvious;
            illogical('{It iobj/She} {is}n&rsquo;t here. {You/He}&rsquo;ll have
                to leave {the dobj/him} somewhere {it iobj/she} can find {it
                dobj/him}. ');
        }
        action
        {
            replaceAction(PrayAt, altar);
        }
    }
    dobjFor(PrayToAt)
    {
        action()
        {
            /*
             *   Bıaulx ꝺıeux ꝺıſt ıl tout ce poez.
             *   Sıl voꝰ plaıſt ma requeſte oez
             *   [...]
             *   Et la belle qͥ mon cueᷣ emble
             *   Qui ſı bıen yuoyꝛe reſſemble.
             *   Deuıengne ma loyal amye
             *   De fēme aıt coꝛps ame et vıe
             *      (MS. Douce 195, fol. 151r)
             */
            local offering;
            foreach (offering in gIobj.contents);
            if (!keywordToken.scoreCount)
                "<<one of>><q>O Aphrodite,</q> {you/he} say{s}, <q>comforter of
                hopeless lovers, hear my prayer! May <<statue.thatNom>> to whom
                I have given my heart be given body, soul, and life. And a
                colorful personality. And&mdash;</q>\b
                {You/He} {is} interrupted by a shimmering about {the iobj/him}.
                As {you/he} watch{es}, it takes the form of a callipygian
                goddess.\b
                <q>Mortal, I have heard your heart-felt and oft-repeated plea,
                and I will take pity on you,</q> says {the dobj/she}. <q>If you
                give me a token of your love as an offering, I will give you
                the <<highlight 'keyword'>> of life. Speak this word in the
                presence of a mirror, and I will grant your request.</q>\b
                {It dobj/She} fade{s} away, adding, <q>As for her colorful
                personality, just look around you.</q> <<or>><<stopping>>";
            else if (key.location)
                "<q>O Aphrodite,</q> {you/he} say{s}, <q>what am I supposed to
                do again?</q>\bThe goddess reappears and reminds you to speak
                the keyword of life at a mirror. <<one of>><q>What&rsquo;s the
                keyword, then?</q> <q>Gods help those who help themselves.
                Figure it out yourself.</q><<or>><q>Why a mirror?</q> <q>I like
                mirrors.</q><<purely at random>> ";
            else if (offering == necklace)
            {
                "Aphrodite reappears. <q>A necklace! Perfect!</q> The necklace
                disappears in a bright flash. When {your} eyes readjust,
                {you/he} see{s} <<key.aNameObj>> lying in its place. ";
                necklace.moveInto(nil);
                key.makePresent();
            }
            else if (+offering)
                "{The dobj/She} reappear{s}. {It dobj/She} eye{s}
                <<offering.theNameObj>> skeptically. <q><<one of>>No
                <<highlight 'comment'>>.<<or>>You call <i>that</i> a token of
                love?<<or>>\^<<offering.aNameObjShort>>? <<if offering ==
                goldNugget>>You won&rsquo;t get it down the
                steps.<<else>>Really?<<end>><<or>>Come on, mortal, it&rsquo;s
                not that difficult!<<then at random>></q> ";
            else
                "<q>I heard you the first time,</q> {subj dobj}say{s} {the
                dobj/she}. <q>Prove your devotion by offering a token of your
                love at {the iobj/him}, or the deal&rsquo;s off.</q> ";
        }
    }
;

sinkRoom: Room 'Washroom'
    "Sculpting is a dusty business. You use this sink to clean off after a hard
    day&rsquo;s work. Beside the sink is a small side table, and on the wall is
    a calculator. The rest of the studio is south and west. "
    south = altarRoom
    southwest = entrance
    west = workbenchRoom
    roomParts = (roomParts = inherited() - [defaultSouthWall, defaultWestWall])
;

property level, overflowing;
export overflowing;
export level 'waterLevel';
+ sink: Fixture, WaterContainer
    '(auto) (mop) auto-sink/autosink/backsplash/bowl/drain/faucet/sink' 'sink'
    "This is a state-of-the-art mop sink with anti-miasmic coating and bronze
    backsplash. It is so modern, there are no handles or other obvious ways to
    turn it on.
    <.p><<if overflowing>>The faucet is stuck in the on position and the sink
    is overflowing.
    <<else unless level < 19500>>It is full to the brim with water.
    <<otherwise if level >= 15000>>It is full of water.
    <<otherwise unless level < 10000>>It is half full of water.
    <<else if level >= 1000>>There is some water in the sink.
    <<else if level > 0>>A small puddle has formed at the bottom of the sink. "
    materialWord = 'bronze' 'metal'
    level = not in ([lst]) { return argcount; }
    not = in()
    overflowing = nil
    current = self
    setLevel(level:)
    {
        targetobj.current.overflowing = level == nil;
        targetobj.current.level = max(min(level ?? 0, 20000), 0);
    }
    iobjFor(CleanWith) remapTo(CleanWith, DirectObject, sinkWater)
    dobjFor(TurnOn) {
        verify {
            if (overflowing)
                illogicalAlready('{The dobj/He} {is} already on. ');
            logical;
        }
        check {
            failCheck('{You/He} can&rsquo;t see any way to turn {it dobj/him}
                on. <<if manual.described>><<one of>><<or>>(The manual said to
                use the calculator add-on.) <<stopping>>');
        }
    }
    dobjFor(TurnOff) {
        verify {
            if (!overflowing)
                illogicalAlready('{The dobj/He} {is} already off. ');
            logical;
        }
        check {
            failCheck('{You/He} can&rsquo;t see any way to turn {it dobj/him}
                off. <<if manual.described>><<one of>><<or>>(The manual said to
                use the calculator add-on.) <<stopping>>');
        }
    }
;

++ sinkWater: Fixture
    vocabWords = (rexReplace('/', sink.vocabWords, ' ') + ' water')
    name = 'water'
    desc = "<<sink.desc>>"
    disambigName = 'water in <<sink.theName>>'
    hideFromAll(action) { return delegated Component(action); }
    dobjFor(Drink)
    {
        verify { illogical('''{You're} not thirsty. '''); }
    }
    dobjFor(Taste) remapTo(Drink, DirectObject)
    iobjFor(CleanWith)
    {
        verify {
            if (!sink.overflowing)
            {
                if (sink.level == 0 && !gAction.isImplicit)
                    illogicalNow('There is no water in the sink. ');
                else if (sink.level < 1e3)
                    illogicalNow('There is not enough water in the sink<<if
                        gAction.isImplicit>> to clean anything with<<end>>. ');
            }
        }
    }
    iobjFor(PutIn) remapTo(PutIn, DirectObject, sink)
    dobjFor(TurnOn) remapTo(TurnOn, sink)
    dobjFor(TurnOff) remapTo(TurnOff, sink)
;

+ sideTable: Chair, Fixture 'small side bracket/table*tables' 'side table'
    "<<first time>>Upon closer inspection, you see that \v<<only>>The table is
    bracketed to the wall. "
;

++ comb: Thing 'comb/tool*tools' 'comb'
    "A tool to keep your hair tidy. "
;

++ manual: Readable '"operator\'s" book/manual' 'manual'
    "<center ><<highlight 'Operator'>>&rsquo;s Manual</center>\b
    <bq>To control the auto-sink, use the calculator add-on to enter the
    desired volume of water. It supports the standard Thalassa++ unary and
    binary operations:<<ul(true,
        '<kbd>+</kbd> -- addition',
        '<kbd>-</kbd> -- subtraction',
        '<kbd>*</kbd> -- multiplication',
        '<kbd>/</kbd> -- division',
        '<kbd>%</kbd> -- modulo',
        '<kbd>~</kbd> -- bitwise NOT',
        '<kbd>!</kbd>\u200B -- logical NOT',
        '<kbd>&amp</kbd> -- bitwise AND',
        '<kbd>|</kbd> -- bitwise OR',
        '<kbd>^</kbd> -- bitwise XOR',
        '<kbd>&lt&lt;</kbd> -- shift left',
        '<kbd>&gt;&gt;</kbd> -- arithmetic shift right',
        '<kbd>&gt;&gt;&gt;</kbd> -- logical shift right'
    )>>
    For example,\n
    \t\t<<aHref('calculate 69 * 105', 'CALCULATE 69 TIMES 105')>>\n
    to fill the basin with <<% ,d 0x69 * 0105>> kochliaria<!-- an ancient Greek
    unit, < 5 ml >.\b
    Warning: Do not use big <<highlight 'number'>>s or divide by zero!</bq>"
;

+ calculator: Fixture, Thing 'add-on/addon/button/buttons/calculator/screen'
    'calculator'
    "The calculator is <<highlight 'built in'>>to the wall beside the sink. It
    has buttons for all the standard unary and binary operations.
    <<if(screen)>>The screen reads <<screen>>"
    screen = nil
    literalMatch = ''
;

method wrongContextMsg()
{
    return '<samp><<highlight '<<'ERROR'>>'>> {{can\'t use
        \"<<literalMatch.htmlify>>\" in that context}}</samp>. ';
}

portico: OutdoorRoom 'Portico'
    "Columns line the portico stretching east and west, and steps lead down to
    the south. The door leads back in, and beside the door is a basin. A
    <<highlight 'label'>> is affixed to the doorpost. "
    north = (__objref(error, error))
    in asExit(north)
    south: FakeConnector
    {
        "You begin moving away from the door, but then you remember the statue.
        The gods won&rsquo;t bring her to life if you give up this easily!
        <<setMethod(&isConnectorApparent, {origin, actor: nil})>>"
    }
    east = (south)
    west = (south)
    down asExit(south)
    roomParts = (roomParts = inherited() + [defaultNorthWall])
    afterTravel(traveler, connector)
    {
        if (!bird.seen && basin.isMirror)
        {
            bird.makePresent();
            "<.p>\^<<bird.aName>> fl<<bird.verbEndingIes>> in through the
            columns<<if bird.canSee(net) && net.isIn(traveler)>>.
            \^<<bird.itNom>> circle<<bird.verbEndingS>> above <<basin.theName>>
            before alighting on the side of it opposite
            <<traveler.theNameObj>><<else>> and alight<<bird.verbEndingS>> in
            <<basin.theName>><<end>>. ";
        }
        inherited(traveler, connector);
    }
;

+ error: LockableWithKey, Door ->door 'door'
    name = (otherSide.name)
    desc = (otherSide.desc)
    materialWord = 'wood' 'wooden'
    keyList = (otherSide.keyList)
;

+ Fixture 'column*columns' 'columns'
    "There are six <<one of>>short columns with simple capitals<<or>>slender
    columns with scrollwork in the capitals<<or>>tall columns with ornate
    capitals<<sticky random>>. Above the architrave is a frieze depicting some
    of your wares. <<first time>>The cornice overhangs the frieze a bit too
    much, you think; perhaps you should shorten it. You try to concentrate on
    the architecture of the portico, stoically ignoring what you cannot change,
    but it doesn&rsquo;t work. It never does. <<only>>"
    isPlural = true
;

/*
 *   Puıs q̄ pymalıon ay nom.
 *      (MS. Douce 195, fol. 149v)
 */

+ Fixture, Readable 'label/doorpost' '<<highlight 'label'>>'
    "The <<highlight 'label'>> says <q>Pygmentalion</q><<first time>> (which is
    your <<highlight 'name'>>)<<only>>. "
;

/*
 *   Nama ıaꝺıs ou boys rame.
 *   A la fontaine clere et pure.
 *   Narcıſus ſa pꝛopꝛe fıgure.
 *   Quāt cuıꝺa ſa ſoıf eſtanchıer
 *   Noncq ne ſen pot reuanchıer.
 *   Puis en fu moꝛt ſelon lıſtoıre.
 *   Qui encoꝛ eſt ꝺe grāt memoyꝛe.
 *   Dōc ſuys ıe moīs fol touteſuoıˢ.
 *   Car quāt ıe vueıl a ceſte voıs
 *   Et la pꝛen ⁊ lacolle et baıſe.
 *   Sen puıˢ mieulx ſouffrır ma meˢ-
 *         aıſe.
 *      (MS. Douce 195, fol. 149v)
 */

+ basin: Fixture, WaterContainer
    '(bird) mirror basin/bath/birdbath/fountain/mosaic/pool/tile/tiles' 'basin'
    "It is shallow but wide, and lined with tiles. It used to be a fountain,
    but it stopped working after they installed the new sink. Something to do
    with water pressure, no doubt. Now you just use it as a birdbath.
    <.p><<if overflowing>>Water is spilling over the sides in a turbulent flow.
    <<else if level >= 19500>>It is full to the brim with water. You can see
    your reflection<<if obscuringItem == bird>>, though it is distorted by the
    ripples issuing from <<obscuringItem.theName>><<else if obscuringItem>>,
    though it is partly obscured by <<obscuringItem.theName>><<else>> as
    clearly as Narcissus saw his. At least you are not as foolish as he was:
    you can physically touch the object of your affections, which is some
    consolation<<end>>.
    <<else if level >= 15000>>It is full of water. You can see your
    reflection<<if obscuringItem == bird>>, though it is distorted by the
    ripples issuing from <<obscuringItem.theName>><<else if obscuringItem>>,
    though it is partly obscured by <<obscuringItem.theName>><<end>>.
    <<else if level >= 10000>>It is half full. From the right angle, you can
    make out a shadowy reflection of the columns, but nothing more.
    <<else if level >= 1000>>There is some water in it, but you can still make
    out the mosaic lining the basin.
    <<else if level > 0>>A small puddle has formed at the bottom of the basin.
    "
    level = 0
    overflowing = nil
    isMirror = (level >= 15000)
    getState = (isMirror ? mirrorState : nonMirrorState)
    allStates = [mirrorState, nonMirrorState]
    setLevel(level:)
    {
        delegated sink.setLevel(_: sourceTextOrder ? level: nil, level: level);
    }
    iobjFor(CleanWith) maybeRemapTo(basinWater.location, CleanWith,
                                    DirectObject, basinWater)
    obscuringItem
    {
        return contents
            .sort(SortAsc, {x, y: toInteger(y == bird) - toInteger(x == bird)})
            .valWhich({obj: !obj.ofKind(Fixture)});
    }
    dobjFor(Examine)
    {
        action
        {
            if (canBeTouchedBy(gActor))
                for (local item in contents)
                    if (item.ofKind(Hidden) && !item.discovered)
                        item.discover();
            inherited();
        }
    }
;

++ basinWater: Fixture
    vocabWords = (rexReplace('/', basin.vocabWords, ' ') + ' water')
    name = 'water'
    desc = "<<basin.desc>>"
    getState = nonMirrorState
    allStates = (basin.allStates)
    disambigName = 'water in <<basin.theName>>'
    hideFromAll(action) { return delegated Component(action); }
    dobjFor(Drink)
    {
        verify
        {
            illogical('Drinking from a birdbath might not be the best idea. ');
        }
    }
    dobjFor(Taste) remapTo(Drink, DirectObject)
    iobjFor(CleanWith)
    {
        preCond = [touchObj]
        verify {
            illogical('Washing something in a birdbath is unlikely to get it
                clean. ');
        }
    }
    iobjFor(PutIn) remapTo(PutIn, DirectObject, basin)
;

mirrorState: ThingState
    stateTokens = ['mirror']
;

nonMirrorState: ThingState
;

++ cageKey: Hidden, Key
    '(cage) clean grime grimy key/tool*keys tools' 'iron key'
    "It is <<aNameFrom('<<unless clean || moved>>grimy <<end>>iron')>> key.
    <<if moved && !clean>>It is covered in grime from the drain of
    <<basin.theName>>. "
    materialWord = 'iron' 'metal'
    clean = nil
    getState = (clean ? cleanState : grimyState)
    allStates = [cleanState, grimyState]
    dobjFor(CleanWith)
    {
        action
        {
            clean = true;
            "{You/He} clean{s} {the dobj/him}. ";
        }
    }
;

/*
 *   Par grāt amoᷣ loꝛs ſentrebꝛacet.
 *   Com.ii.coulōbıaux ſentrebaıſēt.
 *   Moult ſētraimēt moult ſētreaıſēt.
 *      (MS. Douce 195, fol. 151v)
 */

++ bird: PresentLater, Thing
    'bird/dove/pigeon/turtle/turtle-dove/turtledove' 'bird'
    "It&rsquo;s a turtle-dove: an auspicious omen! "
    showAfterTravelMessage(traveler)
    {
        return canBeSeenBy(gPlayerChar) && canSee(net) && net.isIn(traveler);
    }
    afterTravel(traveler, connector)
    {
        if (showAfterTravelMessage(traveler))
            "<.p>\^<<nameIs>> startled and hops to the far side of
            <<location.theName>>. ";
        inherited(traveler, connector);
    }
    afterAction()
    {
        if (gActionIs(Wait))
            extraReport('<.p><<specialDesc_>>');
    }
    specialDesc_ = '<<if gActionIn(Travel, TravelVia) ?
        !showAfterTravelMessage(gActor) : rand(2) == 0>>\^<<theName>> <<one
        of>>preens itself<<or>>flutters around <<location.theName>><<or>>drinks
        from <<location.theName>><<or>>ruffles its feathers in
        <<location.theName>><<or>>coos<<at random>>. '
    specialDesc = "<<specialDesc_>>"
    specialDescBeforeContents = true
    bulk = 5
    dobjFor(Attack)
    {
        preCond = (inherited() - touchObj)
        action
        {
            reportFailure('{The dobj/He} effortlessly dodge{s} {your/his}
                attack. ');
        }
    }
    dobjFor(AttackWith)
    {
        remap = (gIobj == net
            ? [PutInAction, DirectObject, IndirectObject]
            : [AttackAction, DirectObject])
    }
    iobjFor(ThrowAt)
    {
        action
        {
            reportFailure('{The iobj/He} dart{s} out of the way. ');
            if (location && !location.ofKind(BasicLocation))
                replaceAction(ThrowAt, gDobj, location);
        }
    }
    dobjFor(Clean)
    {
        preCond = (inherited() - (bird.canSee(basin) ? touchObj: []))
        check
        {
            if (bird.canSee(basin))
                failCheck('{The dobj/He} {does} not need {your} help using the
                    birdbath. ');
            else
                inherited();
        }
    }
    dobjFor(Take)
    {
        action
        {
            reportFailure('{The dobj/He} hop{s} out of arm&rsquo;s reach. ');
        }
    }
    dobjFor(PutIn)
    {
        preCond = inherited() - (gIobj == net ? objHeld : [])
        action
        {
            reportFailure('{You/He} swipe{s} at {the dobj/him} with {the
                iobj/him} but {it dobj/he} dart{s} out of the way. {It dobj/He}
                flap{s} noisily out of the portico, through the columns and
                away towards the west. ');
            moveInto(nil);
            eventualLocation = nil;
        }
    }
;

modify touchObj
    checkPreCondition(obj, allowImplicit)
    {
        local ret = inherited(obj, allowImplicit);
        if (allowImplicit && obj == bird && !gActionIs(Take))
        {
            tryImplicitAction(Take, obj);
            exit;
        }
        return ret;
    }
;

/* Water */

class WaterContainerDescContentsLister: thingDescContentsLister
    container = nil
    construct(container)
    {
        self.container = container;
    }
    hasEnoughWater = (container.level >= 1000 || container.overflowing)
    showListPrefixWide(itemCount, pov, parent) { }
    showListSuffixWide(itemCount, pov, parent) { }
    showArrangedList(
        pov, parent, lst, options, indent, infoTab, itemCount, singles, groups,
        groupTab, origLst)
    {
        if (itemCount == 0 || options & ListTall || groups.length)
            inherited(
                pov, parent, lst, options, indent, infoTab, itemCount, singles,
                groups, groupTab, origLst);
        else
        {
            groups = new Vector();
            groupTab = new LookupTable();
            local floaters = new Vector();
            local sinkers = new Vector();
            local hasEnoughWater = self.hasEnoughWater;
            for (local item in lst)
                (container.floatingObjects.indexOf(item) != nil
                    ? floaters : sinkers).append(item);
            "<.p>";
            for (local subLstWithDesc in [
                [floaters, !hasEnoughWater ? nil
                    : '<<highlight 'float'>>ing on the surface of the water'],
                [sinkers, 'lodged in the drain']
            ])
            {
                local subLst = subLstWithDesc[1];
                local desc = subLstWithDesc[2];
                if (subLst.length != 0)
                {
                    if (desc)
                        "\^";
                    else
                        thingDescContentsLister.showListPrefixWide(
                            subLst.length, pov, parent);
                    inherited(
                        pov, parent, subLst, options, indent, infoTab,
                        subLst.length, subLst, groups, groupTab, origLst);
                    if (desc)
                        " <<if subLst.length == 1>>is<<else>>are<<end>>
                        <<desc>>. ";
                    else
                        thingDescContentsLister.showListSuffixWide(
                            subLst.length, pov, parent);
                }
            }
        }
    }
;

class WaterContainer: RestrictedContainer
    grimyObjects = [key, cageKey]
    floatingObjects = [idol, needle]
    validContents = (grimyObjects + floatingObjects)
    contentsListedSeparately = true
    descContentsLister = new WaterContainerDescContentsLister(self)
    iobjFor(PutIn) {
        verify {
            if (validContents.indexOf(gDobj) == nil)
                illogical('{The dobj/He} <<if overflowing || level !=
                    0>>would<<otherwise>>might<<end>> get wet. ');
        }
        action {
            if (grimyObjects.indexOf(gDobj) != nil)
                replaceAction(CleanWith, gDobj, gIobj);
            inherited();
            if (overflowing)
                washContentsAway();
        }
    }
    washContentsAway()
    {
        if (sink.current.contents)
        {
            if (canBeSeenBy(gActor))
            {
                local tab = gActor.visibleInfoTable();
                sink.current.setContentsSeenBy(tab, gActor);
                for (local grimyObject in grimyObjects)
                    tab.removeElement(grimyObject);
                local lst = sink.current.getContentsForExamine(
                    washedAwayContentsLister, tab);
                washedAwayContentsLister.showList(
                    gActor, sink.current, lst, ListRecurse, 0,
                    gActor.visibleInfoTable(), nil, examinee: sink.current);
            }
            for (local item in sink.current.contents)
                if (!item.ofKind(Fixture) && grimyObjects.indexOf(item) == nil)
                    item.moveInto(sink.current.location);
        }
    }
    washedAwayContentsLister: thingDescContentsLister
    {
        showListPrefixWide(itemCount, pov, parent) { "\^"; }
        showListItem(obj, options, pov, infoTab)
        {
            say(obj.withVisualSenseInfo(pov, infoTab[obj], &theName));
        }
        showListSuffixWide(itemCount, pov, parent)
        {
            " <<tSel('get<<if itemCount == 1>>s', 'got')>> washed away onto
            <<(gActor.canSee(defaultFloor) ? defaultFloor :
            defaultGround).theName>>. ";
        }
    }
;

trickling(water) multimethod
{
    if (sink.overflowing)
    {
    dirs: for (local dir in Direction.allDirections)
        {
            if (dir.ofKind(RelativeDirection))
                continue;
            if (dir.ofKind(ShipboardDirection))
                continue dirs;
            if (water.eventualLocation.(dir.dirProp) == __objref(entrance))
                return 'trickling <<dir.name>>';
        }
    }
    return 'a stagnant puddle';
}

class Water:PresentLater,Fixture'(floor) (ground) water puddle water''water'
    "The water on the floor is <<trickling(self)>>. "
    disambigName = 'water on the floor'
    specialDesc = "The floor is covered with water. "
    dobjFor(Drink)
    {
        preCond = [touchObj]
        verify { }
        check { failCheck('{You\'re} not thirsty. '); }
    }
    dobjFor(Taste) remapTo(Drink, DirectObject)
    iobjFor(CleanWith)
    {
        verify { illogical('The water on the ground is too dirty. '); }
    }
;

Water template +location | ~location "specialDesc"? inherited;
Water +altarRoom;
Water +sinkRoom { ;; };
Water { +workbenchRoom };

entranceWater: Water +entrance
    "<<if sink.overflowing>>At your feet, all the water from the sink flows
    into a <<%-o 02>>-dactyl slit in the baseboard. <<else>><<inherited>>"
    vocabWords = 'water baseboard/puddle/slit water'
;
trickling(entranceWater w)
{
    return sink.overflowing ? 'trickling into the wall' : inherited<*>(w);
}

porticoWater: Water ~portico;
trickling(porticoWater w)
{
    return basin.overflowing ? 'trickling down the stairs' : inherited<*>(w);
}

/* Displaying this source code */

modify typographicalOutputFilter
    isActive = true
    activate { isActive = true; }
    deactivate { isActive = nil; }
    filterText(ostr, val) { return isActive ? inherited(ostr, val) : val; }
;

transient iris: Deity
    'iris' 'Iris'
    location = (gPlayerChar)
    isProperName = true
    isHer = true
    file = nil
    screenHeight()
    {
        if (!systemInfo(SysInfoBanners))
            return 25;
        local probe = bannerCreate(nil, BannerAfter, statuslineBanner.handle_,
            BannerTypeText, BannerAlignTop, 100, BannerSizePercent, 0);
        local height = min(100, max(10, bannerGetInfo(probe)[3] - 12));
        bannerDelete(probe);
        // Recalculating the screen height in XTads causes significant
        // noticeable flickering when the scrollback buffer is very full. It is
        // probably safe enough in practice to cache it.
        if (systemInfo(SysInfoInterpClass) == SysInfoIClassHTML
            && systemInfo(SysInfoOsName) == 'POSIX_UNIX_MSWINDOWS')
            screenHeight = height;
        return height;
    }
    coverArt
    {
        local supportsPng =
#ifdef TADS_INCLUDE_NET
            true
#else
            systemInfo(SysInfoPng) && !(
            // XTads claims to support PNG but does not.
            systemInfo(SysInfoInterpClass) == SysInfoIClassHTML
            && systemInfo(SysInfoOsName) == 'POSIX_UNIX_MSWINDOWS')
#endif
            ;
        local src = '.system/CoverArt.png';
        if (supportsPng)
            try
            {
                File.openRawResource(src);
            } catch (FileException e) {
                supportsPng = nil;
            }
        local ret = supportsPng ? '<.p><img src=<<src>> width=240>' : '';
        coverArt = ret;
        return ret;
    }
    dobjFor(PrayToAt)
    {
        action()
        {
            gTranscript.flushForInput();
            local resourceName = __FILE__ + '.pygm';
            local needToOpen = file == nil;
            if (needToOpen)
            {
                try
                {
                    file = File.openTextResource(resourceName);
                } catch (FileException e) {
                    "Nothing happens here. ";
                    return;
                }
                file.setCharacterSet('utf-8');
            }
#ifndef TADS_INCLUDE_NET
            // QTads crashes unpredictably in `CHtmlSysWinQt::measure_text` if
            // there is too much complex HTML on the screen.
            if (systemInfo(SysInfoInterpClass) == SysInfoIClassHTML
                && systemInfo(SysInfoOsName) != 'POSIX_UNIX_MSWINDOWS')
                cls();
#endif
            local line = nil;
            try {
                local i = 0;
                local screenHeight = self.screenHeight;
                for (;
                     i < screenHeight && (line = file.readFile()) != nil;
                     ++i)
                {
                    if (i != 0)
                        "<br>";
                    else
                    {
                        "<<one of>>The light coming through the window
                        refracts, projecting a rainbow onto the blank wall.
                        {Your/His} vision swims. As {you/he} stare{s} at the
                        rainbow, the colors shift and coalesce, forming words.
                        <<coverArt>>
                        <<or>>The rainbow reappears. {You/He} <<if
                        needToOpen>>start{s} reading again from the
                        beginning<<else>>continue{s} reading where {you/he}
                        left off<<end>>. <<stopping>>";
                        gTranscript.deactivate();
                        typographicalOutputFilter.deactivate();
                        "<pre>";
                    }
                    if (line.compareTo('\n'))
                    {
                        local tagStyles = [
                            // Comment
                            'c' -> ['<i><font color=#0080ff>', '</font></i>'],
                            // Comment.Hashbang
                            'ch' -> ['<i><font color=#0080ff>', '</font></i>'],
                            // Comment.Multiline
                            'cm' -> ['<i><font color=#0080ff>', '</font></i>'],
                            // Comment.Preproc
                            'cp' -> ['<font color=#0080ff>', '</font>'],
                            // Comment.PreprocFile
                            'cpf' -> ['<font color=#0080ff>', '</font>'],
                            // Comment.Single
                            'c1' -> ['<i><font color=#0080ff>', '</font></i>'],
                            // Comment.Special
                            'cs' -> [
                                '<b><i><font color=#0080ff>', '</font></i></b>'
                            ],
                            // Keyword
                            'k' -> ['<b><font color=#2c5dcd>', '</font></b>'],
                            // Keyword.Constant
                            'kc' -> ['<b><font color=#2c5dcd>', '</font></b>'],
                            // Keyword.Declaration
                            'kd' -> ['<b><font color=#2c5dcd>', '</font></b>'],
                            // Keyword.Namespace
                            'kn' -> ['<b><font color=#2c5dcd>', '</font></b>'],
                            // Keyword.Pseudo
                            'kp' -> ['<b><font color=#2c5dcd>', '</font></b>'],
                            // Keyword.Reserved
                            'kr' -> ['<b><font color=#2c5dcd>', '</font></b>'],
                            // Keyword.Type
                            'kt' -> ['<b><font color=#2c5dcd>', '</font></b>'],
                            // Name.Attribute
                            'na' -> ['<i><font color=#2c5dcd>', '</font></i>'],
                            // Name.Builtin
                            'nb' -> ['<b><font color=#5918bb>', '</font></b>'],
                            // Name.Builtin.Pseudo
                            'bp' -> ['<b><font color=#5918bb>', '</font></b>'],
                            // Name.Class
                            'nc' -> ['<u><font color=#c5060b>', '</font></u>'],
                            // Name.Constant
                            'no' -> ['<font color=#318495>', '</font>'],
                            // Name.Entity
                            'ni' -> ['<b><font color=#5918bb>', '</font></b>'],
                            // Name.Exception
                            'ne' -> ['<b><font color=#5918bb>', '</font></b>'],
                            // Name.Function
                            'nf' -> ['<font color=#c5060b>', '</font>'],
                            // Name.Function.Magic
                            'fm' -> ['<font color=#c5060b>', '</font>'],
                            // Name.Tag
                            'nt' -> ['<b><font color=#2c5dcd>', '</font></b>'],
                            // Number
                            'm' -> ['<b><font color=#5918bb>', '</font></b>'],
                            // Number.Bin
                            'mb' -> ['<b><font color=#5918bb>', '</font></b>'],
                            // Number.Float
                            'mf' -> ['<b><font color=#5918bb>', '</font></b>'],
                            // Number.Integer
                            'mi' -> ['<b><font color=#5918bb>', '</font></b>'],
                            // Number.Integer.Long
                            'il' -> ['<b><font color=#5918bb>', '</font></b>'],
                            // Number.Hex
                            'mh' -> ['<b><font color=#5918bb>', '</font></b>'],
                            // Number.Oct
                            'mo' -> ['<b><font color=#5918bb>', '</font></b>'],
                            // Operator
                            'o' -> ['<font color=#2c5dcd>', '</font>'],
                            // Operator.Word
                            'ow' -> ['<b><font color=#2c5dcd>', '</font></b>'],
                            // String
                            's' -> ['<font color=#00994d>', '</font>'],
                            // String.Backtick
                            'sb' -> ['<font color=#00994d>', '</font>'],
                            // String.Char
                            'sc' -> ['<font color=#00994d>', '</font>'],
                            // String.Delimiter
                            'dl' -> ['<font color=#00994d>', '</font>'],
                            // String.Doc
                            'sd' -> ['<font color=#00994d>', '</font>'],
                            // String.Double
                            's2' -> ['<font color=#00994d>', '</font>'],
                            // String.Escape
                            'se' -> ['<b><font color=#c5060b>', '</font></b>'],
                            // String.Heredoc
                            'sh' -> ['<font color=#00994d>', '</font>'],
                            // String.Interpol
                            'si' -> ['<b><font color=#c5060b>', '</font></b>'],
                            // String.Other
                            'sx' -> ['<font color=#00994d>', '</font>'],
                            // String.Regex
                            'sr' -> ['<font color=#00994d>', '</font>'],
                            // String.Single
                            's1' -> ['<font color=#00994d>', '</font>'],
                            // String.Symbol
                            'ss' -> ['<font color=#00994d>', '</font>'],
                            // fallback for other classes
                            * -> ['', '']
                        ];
                        line = rexReplace(
                            R'<(.+?)>(.*?)<>',
                            line,
                            function() {
                                local tags = tagStyles[rexGroup(1)[3]];
                                return concat(
                                    tags[1], rexGroup(2)[3], tags[2]);
                            },
                        );
#ifndef TADS_INCLUDE_NET
                        line = rexReplace(
                            R'&#([0-9]+);',
                            line,
                            {: makeString(toInteger(rexGroup(1)[3])) }
                        );
                        local cs =
                            new CharacterSet(getLocalCharSet(CharsetDisplay));
                        if (!cs.isMappable(line))
                        {
                            local replacements = [];
                            for (local codePoint in line.toUnicode())
                            {
                                if (cs.isMappable(codePoint))
                                    replacements += codePoint;
                                else
                                {
                                    local replacement;
                                    switch (codePoint)
                                    {
                                    case 0x0101:
                                        replacement = 'a[n]';
                                        break;
                                    case 0x0113:
                                        replacement = 'e[n]';
                                        break;
                                    case 0x012B:
                                        replacement = 'i[n]';
                                        break;
                                    case 0x0131:
                                        replacement = 'i';
                                        break;
                                    case 0x014D:
                                        replacement = 'o[n]';
                                        break;
                                    case 0x016B:
                                        replacement = 'u[n]';
                                        break;
                                    case 0x017F:
                                    case 0x02E2:
                                        replacement = 's';
                                        break;
                                    case 0x0304:
                                    case 0xFEFF:
                                        replacement = '';
                                        break;
                                    case 0x0365:
                                        replacement = '[i]';
                                        break;
                                    case 0x1DE3:
                                        replacement = '[ur]';
                                        break;
                                    case 0x1E9F:
                                    case 0xA77A:
                                        replacement = 'd';
                                        break;
                                    case 0x2013:
                                        replacement = '--';
                                        break;
                                    case 0x204A:
                                        replacement = '&amp;';
                                        break;
                                    case 0xA751:
                                        replacement = '[par]';
                                        break;
                                    case 0xA75B:
                                        replacement = 'r';
                                        break;
                                    case 0xA76F:
                                        replacement = '[con]';
                                        break;
                                    case 0xA770:
                                        replacement = '[us]';
                                        break;
                                    default:
                                        replacement = '\\u<<%04X codePoint>>';
                                        break;
                                    }
                                    replacements += replacement.toUnicode();
                                }
                            }
                            line = makeString(replacements);
                        }
                        line = line.findReplace('  ', ' \u00A0');
#endif
                        "<<line.findReplace(['{', '}', '\n'],
                        ['{{', '}}', ''])>>";
                    }
#ifndef TADS_INCLUDE_NET
                    else
                        // The extra space is necessary to get the right
                        // output in both FrobTADS and QTads.
                        "\ ";
#endif
                }
                if (i == 0)
                    "The rainbow reappears, but {you/he} {has} already read the
                    whole thing. ";
                else
                {
                    "</pre>The rainbow fades and {your/his} vision clears. ";
                    typographicalOutputFilter.activate();
                    gTranscript.activate();
                }
                if (line)
                    "<<first time>>\b<.notification>Continue to <<aHref('pray
                    to Iris', 'PRAY TO IRIS')>> to see the next page of
                    text.<./notification><<only>>";
                else
                    "<<first time>>\b<.notification><<aHref('pray to Iris',
                    'PRAY TO IRIS')>> again to restart at the
                    beginning.<./notification><<only>>";
            } finally {
                if (file && line == nil)
                {
                    file.closeFile();
                    file = nil;
                }
            }
        }
    }
;

/* Calculating */

;;;class is: Exception { finalize { } };;; // InvalidSpecificationError

DefineLiteralAction(Calculate)
    checkAction()
    {
        if (defined(calculator) && !gActor.canTouch(calculator))
        {
            { gActor.failCheck('{You/He} {can\'t} do that kind of math in
                {your} head. <<one of>>{You\'re} not Pythagoras!
                <<or>>{You\'re} not Euclid. <<or>>{You\'re} not Aristotle.
                <<or>>{You\'re} not Eratosthenes. <<or>><<or>>(Further attempts
                to calculate mentally won&rsquo;t elicit any more references to
                famous mathematicians. {You/He} {have} reached the end of
                {your} list: {you\'re} not Zeno.) <<or>><<stopping>>'); }
        }
    }
    execAction()
    {
        local op = function(...) { throw new is(); }, a, b;
        local opString = (literalMatch, literalMatch);
        if (numMatch)
            goto binary;
        if (!numMatch2)
            goto doCalculation;
        switch (opString)
        {
        case '!':
        case 'not':
            opString = '!';
            op = {x : !toInteger('<<%_\u0030[1]5.3\170x>>', 16)};
            break;
        case '+':
        case 'plus':
        case 'positive':
            opString = '+';
            op = {self_ : self_};
            break;
        case '-':
        case 'minus':
        case 'negate':
        case 'negative':
            opString = '&#x2212;';
            op = {x : -x};
            break;
        case '~':
        case 'inverse':
        case 'inverse\\of':
            opString = '~';
            op = {x : ~x};
            break;
        }
        goto doCalculation;
    binary: binaryOp:
        switch (opString.toLower())
        {
        case '+':
        case 'plus':
            opString = '+';
            op = {a, b : +a+++b};
            break binaryOp;
        case '-':
        case 'minus':
            opString = '&#8722;';
            op = {a, b : -b-- - -a};
            break;
        case '*':
        case 'times':
        case 'x':
            opString = '&times;';
            op = new function(a, b) { return a * b; };
            break;
        case '/':
        case 'over':
        case 'divided\\by':
            local cs = new CharacterSet(getLocalCharSet(CharsetDisplay));
            opString = cs.isMappable(0x2215) ? '&#x2215;' : '/';
            op = function(a, b) { return a / b; };
            break;
        case '%':
        case 'mod':
        case 'modulo':
            opString = 'mod';
            op = function(a, b, multimethod=b) { return a % multimethod; };
            break;
        case '\<<':
        case 'shl':
        case 'ashl':
        case 'lshl':
            opString = '&lt;&lt;';
            op = {a, b, c? : a << b};
            break;
        case '&':
        case 'and':
            opString = '&amp;';
            op = {a, b : local badness = a, local token = b, badness & token};
            break;
        case '^':
        case 'xor':
            opString = '^';
            op = {a, b, c? : a ^ b};
            break;
        case '|':
        case 'or':
            opString = '|';
            op = {a, b : a | b};
            break;
        case '>\>':
        case 'shr':
        case 'ashr':
            opString = '>>';
            op = {a, b : toInteger('<<(a >> b)>>')};
            break;
        case '>>>':
        case 'lshr':
            opString = '>>>';
            op = {a, b : b ? invokee(a >>> 1, --b) : a};
            break;
        }
        opString = ' <<opString>> ';
    doCalculation:
        "The calculator outputs ";
        try
        {
            a = numMatch ? numMatch.getval(colon : nil) : nil;
            b = numMatch2 ? numMatch2.getval() : nil;
            local result = toInteger(numMatch ? op(a, b) : op(b));
            calculator.setMethod(&screen, method()
            {
                return '<samp><<a>><<opString>><<b>> = <<%d result>></samp>. ';
            });
            local oldLevel = sink.current.level;
            local oldOverflowing = sink.current.overflowing;
            sink.current.setLevel(level: result);
            "<<calculator.screen()>>
            <<if sink.current == basin>>
                <<if oldOverflowing || basin.level != oldLevel>>{You/He}
                hear{s} water flowing through distant pipes, but nothing comes
                out the faucet.
                <<else if result < 0>>The pipes rattle.
                <<end>>
            <<else if sink.level == oldLevel && result <= oldLevel
              && !oldOverflowing>>
                <<if result < 0>>The pipes rattle. <<end>>
            <<else if sink.level == 0>>
                <<if oldOverflowing>>The faucet shuts off and \v<<end>>All the
                water drains from the sink.
            <<else if sink.level < 1000>>
                <<if oldOverflowing>>The faucet shuts off. Most of the water
                drains from the sink.
                <<else if oldLevel < 1000>>
                    <<if sink.level > oldLevel>>Water dribbles from the faucet.
                    <<else>>The puddle at the bottom of the sink shrinks
                    slightly.
                    <<end>>
                <<else>>Water drains from the sink, leaving only a small
                puddle.
                <<end>>
            <<else if sink.level
              < (oldOverflowing ? 20000 : oldLevel)
              - 0x7d0>><<if oldOverflowing>>The faucet shuts off and
              \v<<end>>Some water drains from the sink.
            <<else if sink.level < (oldOverflowing ? 20000 : oldLevel)>><<if
              oldOverflowing>>The faucet shuts off and \v<<end>>The water level
              in the sink goes down slightly.
            <<else if oldOverflowing>>The faucet shuts off. Water stops
            spilling over the edge of the sink.
            <<else>>
                Water flows
                <<if oldLevel >= result - 0x7D0>>briefly <<end>>
                from the
                faucet<<if oldLevel < 15000 && sink.level >= 15000>>, filling
                the sink<<end>>.
                <<if sink.level <= result - 5.556e8>>Enough water to fill an
                Olympic-size swimming pool pours down the overflow hole.
                <<first time>>The hole is small, so it takes quite a
                <<highlight 'long'>> time before all the excess disappears and
                the faucet shuts off. <<only>>
                <<else if sink.level <= result - 17280>>Metretes of excess
                water pour wastefully down the overflow hole.
                <<else if sink.level <= result - 1440>>Choes of excess water
                pour wastefully down the overflow hole.
                <<else if sink.level <= result - 20>>The excess water pours
                down the overflow hole.
                <<else if sink.level < result>>Some excess water trickles down
                the overflow hole.
            ";
        }
        catch (is in)
        {
            calculator.literalMatch = literalMatch.getVal();
            if (calculator.literalMatch == nil
                || calculator.literalMatch.length() == 0)
                calculator.literalMatch = literalMatch;
            calculator.setMethod(&screen, &wrongContextMsg);
            "<<calculator.screen()>>";
        }
        catch (RuntimeError e)
        {
            calculator.setMethod(&screen, new method
            {
                return '<samp><<highlight 'ERROR'>>
                    {{<<e.exceptionMessage>>}}</samp>. ';
            });
            "<<calculator.screen()>>";
            switch (e.errno_)
            {
            case 2008: // division by zero
                "<<if sink.current == sink
                  && (sink.level > 0 || sink.overflowing)>><<if
                  sink.overflowing>>The faucet shuts off and \v<<end>>The water
                in the sink is sucked down the drain.
                <<else if basin.level > 0 || basin.overflowing>>Water comes up
                from the drain<<if basin.overflowing>> and spills over the
                edges of the sink<<else if basin.level >= 15000>> and begins to
                fill the sink<<end>>.
                <<else>>The sink gurgles and the pipes rattle. ";
                sink.current = sink.current == sink ? basin : sink;
                local _tmp = sink.level;
                sink.level = basin.level;
                basin.level = _tmp;
                _tmp = sink.overflowing;
                sink.overflowing = basin.overflowing;
                basin.overflowing = _tmp;
                if (!sink.current.overflowing)
                    break;
                // fall through
            case 2023: // numeric overflow
                if (!sink.current.overflowing)
                    "<<if sink.current == sink>>High-pressure water gushes from
                    the faucet, <<if sink.level < 15000>>filling the sink,
                    <<end>>overwhelming the overflow
                    hole<<if sink.level < 15000>>,<<end>> and spilling over the
                    edge<<if sink.level >= 15000>> of the sink<<end>>. Rivulets
                    begin running down the slight gradient of the floor.
                    <<else>>The pipes shake loudly. ";
                forEachInstance(Water, function(w) {
                    if ((w.eventualLocation == portico) ==
                        (sink.current == basin))
                        w.makePresent();
                });
                sink.current.washContentsAway();
                sink.current.setLevel(level: nil);
                break;
            default:
                throw e;
            }
        }
        if (bird.seen)
            bird.makePresentIf(basin.isMirror);
    }
;

#define miscTokenListFirstToken (tokPunct -> txt_ | tokWord -> txt_ \
    | tokOp -> txt_ | tokString -> txt_ | tokInt -> txt_)

grammar miscToken:
    miscTokenListFirstToken
    : LiteralProd
    getVal() {
        return txt_;
    }
;

grammar miscTokenList:
    miscTokenListFirstToken
    : LiteralProd
;

grammar miscTokenList:
    miscTokenListFirstToken
    miscTokenList
    : LiteralProd
;

grammar miscTokenList:
    ()
    : EmptyLiteralPhraseProd
;

#define CalculateVerbList ('c' | 'calculate' | 'enter' | 'eval' | 'evaluate')
VerbRule(Calculate)
    CalculateVerbList (()|(singleNumber|))
    (tokOp->literalMatch | '!'->literalMatch | 'x'->literalMatch)
    numberPhrase -> numMatch2
    | [badness 400]
    CalculateVerbList miscToken tokOp -> literalMatch miscTokenList
    | [badness 500] CalculateVerbList miscToken -> literalMatch miscTokenList
    : CalculateAction
    verbPhrase = 'calculate/calculating (what) (how) (what)'
;

DefineIAction(CalculateNothing)
    checkAction
    {
        gActor.failCheck('{You/He} {must} be more specific about what {you/he}
            want{s} to calculate. ');
    }
;

VerbRule(CalculateNothing)
    CalculateVerbList
    : CalculateNothingAction
    verbPhrase = 'calculate/calculating'
;

/* Cleaning */

modify VerbRule(Clean)
    [ /**//**/ // /* \\
#define Room Unthing
    badness 500] ('clean' | 'wash') dobjList:
;

grammar predicate(CleanIn):
    ('clean' | 'wash') dobjList ('at' | 'in' | 'with') singleIobj
    : CleanWithAction
    verbPhrase = 'clean/cleaning (what) (in what)'
    askIobjResponseProd = inSingleNoun
    omitIobjInDobjQuery = true
;

modify Thing
    dobjFor(Clean)
    {
        verify
        {
            if (getState() == cleanState)
                illogicalAlready('{The dobj/He} {is} already clean. ');
            else if (getState() == grimyState)
                logicalRank(150, 'grimy');
        }
        check
        {
            if (getState() != grimyState)
                failCheck('{The dobj/He} {does} not need cleaning. ');
        }
        action {
            if (sinkWater.canBeTouchedBy(gActor))
                tryImplicitActionMsg(
                    &silentImplicitAction, CleanWith, self, sinkWater);
            else
                askForIobj(CleanWith);
        }
    }
    dobjFor(CleanWith)
    {
        verify { return inherited Thing.verifyDobjClean(); }
        check { return inherited Thing.checkDobjClean(); }
    }
    iobjFor(CleanWith)
    {
        preCond = [touchObj]
    }
    iobjFor(AttackWith)
    {
        verify
        {
            if (gDobj == chisel)
            {
                if (gIobj == chisel)
                    illogicalSelf('{You/he} {can\'t} strike {the dobj/him} with
                        {itself}. ');
                else
                    illogical('{The iobj/He} {is} not a suitable tool for
                        striking {a dobj/him} with. ');
            }
            else
                inherited();
        }
    }
;

/* Prayer */

VerbRule(Pray)
    'pray' singleDobj
    : PrayAction
    verbPhrase = 'pray/praying (at/to what)'
;

DefineTAction(Pray)
    whatObj(which) { return 'what/<<libMessages.whomPronoun>>'; }
    adjustDefaultObjectPrep(prep, obj)
    {
        return isAnimate(obj) ? 'to ' : 'at ';
    }
    isAnimate(obj)
    {
        return obj
            && (obj.isHer || obj.isHim || obj.ofKind(Actor) || obj == idol);
    }
;

modify Thing
    dobjFor(Pray)
    {
        remap = [
            PrayAction.isAnimate(gDobj)
            ? PrayToAction : PrayAtAction,
            DirectObject
        ]
    }
;

VerbRule(PrayTo)
    ('laud' | 'petition' | 'praise' | 'pray' 'to' | 'worship') singleDobj
    : PrayToAction
    verbPhrase = 'pray/praying (to whom)'
;

modify Thing
    dobjFor(Pray)
    {
        verify
        {
            illogical('That is illogical! ');
        }
    }
;

DefineTAction(PrayTo);

modify Thing
    dobjFor(PrayTo)
    {
        verify
        {
            illogical('{subj actor}Praying to {the dobj/him} would make the
                gods jealous. ');
        }
    }
;

VerbRule(PrayAt)
    ('laud' | 'petition' | 'praise' | 'pray' | 'worship') 'at' singleDobj
    : PrayAtAction
    verbPhrase = 'pray/praying (at what)'
;

DefineTAction(PrayAt);

modify Thing
    dobjFor(PrayAt)
    {
        verify
        {
            illogical('{You/He} {cannot} pray at {the dobj/him}. ');
        }
    }
;

VerbRule(PrayToAt)
    ('laud' | 'petition' | 'praise' | 'pray' ('to'|) | 'worship') singleDobj
    'at' singleIobj
    | ('laud' | 'petition' | 'praise' | 'pray' | 'worship') 'at' singleIobj
    'to' singleDobj
    : PrayToAtAction
    verbPhrase = 'pray/praying (to whom) (at what)'
;

DefineTIAction(PrayToAt);

modify Thing
    dobjFor(PrayToAt)
    {
        verify {
            illogical('{subj actor}Praying to {the dobj/him} would make the
                gods jealous. ');
        }
    }
    iobjFor(PrayToAt)
    {
        verify
        {
            illogical('{You/He} {cannot} pray at {the iobj/him}. ');
        }
    }
;

/* Bug fixes for adv3 */

modify Actor
    canTalkTo(actor)
    {
        if (actor.communicationSenses == nil)
            return nil;
        return inherited(actor);
    }
;

modify TryAsActorResolveResults
    unknownNounPhrase(match, resolver) { return []; }
;

modify playerActionMessages
    moveNoEffectMsg = '{subj actor}<<inherited>>'
    pullNoEffectMsg = '{subj actor}<<inherited>>'
    pushNoEffectMsg = '{subj actor}<<inherited>>'
    shouldNotBreakMsg = '{subj actor}<<inherited>>'
;

/* Sundry modifications */

modify VerbRule(GiveTo)
    ('give' | 'offer') dobjList 'to' singleIobj
    | 'offer' dobjList ('at' | 'on') singleIobj
    :
;

modify VerbRule(GiveToWhom)
    :
    verbPhrase = 'offer/offering (what) (to what)'
;

VerbRule(Hug)
    ('embrace' | 'hug') singleDobj
    : HugAction
    verbPhrase = 'hug/hugging (what)'
;

DefineTAction(Hug);

modify VerbRule(PutIn)
    ('place' | 'put' | 'set') dobjList
    ('in' | 'in' 'to' | 'inside' | 'inside' 'of' | 'into') singleIobj
    | ('capture' | 'catch') dobjList 'in' singleIobj
    | ('capture' | 'catch' | 'get' | 'pick' 'up' | 'take') dobjList
    'with' singleIobj
    | 'pick' dobjList 'up' 'with' singleIobj
    :
;

modify VerbRule(Take)
    ('capture' | 'catch' | 'get' | 'pick' 'up' | 'take') dobjList
    | 'pick' dobjList 'up'
    :
;

modify LockableWithKey
    breakingWouldBeUseful = nil
    dobjFor(Break)
    {
        verify = breakingWouldBeUseful && knownKeyList.length == 0
            ? nonObvious : inherited()
        check
        {
            failCheck('Rather than destroying {your} possessions, it would be
                better in the long run if {you/he} could just find the key. ');
        }
    }
;

modify NonPortable
    dobjFor(Examine) { verify { inherited Thing; } }
;

modify Thing
    aNameObjShort = (aNameObj)
    dobjFor(GiveTo)
    {
        verify
        {
            if (!isIn(gActor))
                logicalRank(80, 'not held');
            inherited();
        }
    }
    dobjFor(Hug)
    {
        preCond = [touchObj]
        action
        {
            "{subj actor}Hugging {the dobj/him} has no obvious effect. ";
        }
    }
    dobjFor(Read) { verify { nonObvious; } }
;

modify libMessages
    whomPronoun = 'who'
;

modify playerActionMessages {
    cannotPutInRestrictedMsg = 'There is no reason for {you/him} to put {that
        dobj/him} in {the iobj/him}. '
}

/* Help */

modify VerbRule(About) 'about' | 'info' :;

VerbRule(Help)
    'help'
    : HelpAction
    verbPhrase = 'show/showing help'
;

DefineSystemAction(Help)
    objectPlaceholder
    {
        return objectPlaceholder = outputManager.htmlMode
            ? '<var>object</var>'
            : '[object]';
    }
    execSystemAction
    {
        "<.parser>This is a work of interactive fiction. Type commands at the
        prompt to interact with the fiction. Basic commands (some of which
        have abbreviations) include:<<ul(nil,
            'Looking around:' + ul(nil,
                'LOOK (L)',
                'EXAMINE (X) <<objectPlaceholder>>',
                'READ <<objectPlaceholder>>',
                'SEARCH <<objectPlaceholder>>'
            ),
            'Moving around:' + ul(nil,
                'NORTH (N)',
                'SOUTH (S)',
                'EAST (E)',
                'WEST (W)',
                'UP (U)',
                'DOWN (D)'
            ),
            'Inventory management:' + ul(nil,
                'INVENTORY (I)',
                'GET <<objectPlaceholder>>',
                'DROP <<objectPlaceholder>>',
                'PUT <<objectPlaceholder>> IN/ON <<objectPlaceholder>>',
                'WEAR <<objectPlaceholder>>'
            ),
            'Meta commands:' + ul(nil,
                'UNDO',
                'SAVE',
                'RESTORE',
                'QUIT'
            )
        )>>Other useful verbs should become obvious when necessary.
        <.p>This particular interactive fiction is an allegorical romance, also
        known as a puzzle-based adventure game. Each word appearing in the
        story is an allegory. For example, the word <q>help</q> is an allegory
        for the concept of help. The story assumes a basic familiarity with
        written language so this lesson in semiotics need not be belabored.
        <.p>If you are not familiar with written language, then learning to
        read is your first puzzle. Congratulations on making it this far!
        Otherwise, most puzzles involve going to various locations and using
        various objects. Some objects have side effects &ndash; for example,
        the pole scares the bird.
        <.p>For a much more verbose introduction to interactive fiction, not
        written for <<iOrQ(versionInfo.name)>> but part of the TADS 3 standard
        library, type <<aHref('instructions', 'INSTRUCTIONS')>>.<./parser>";
    }
;

modify InstructionsAction
    crueltyLevel = (crueltyLevel = [
        'Merciful' -> 0,
        'Polite' -> 1,
        'Tough' -> 1,
        'Nasty' -> 1,
        'Cruel' -> 2,
        * -> inherited
    ][versionInfo.forgivenessLevel])
    customVerbs = [
        'CALCULATE 69 TIMES 105',
        'PRAY TO IRIS',
        'SAY "HAPAX LEGOMENON"'
    ]
    conversationVerbs = []
    conversationAbbr = ""
    showConversationChapter { }
;

/* Catalog of shipboard directions */

replace grammar directionName(port): ' ': object;

replace grammar directionName(starboard): ' ': object;

replace grammar directionName(aft): ' ': object;

replace grammar directionName(fore): ' ': object;

replace VerbRule(Port) (): object;

replace VerbRule(Starboard) (): object;

/* Extended grammar for 'in' and 'out' */

modify grammar directionName(in): 'in' | 'inside':
   dir = inDirection
;
modify /**//**/ // /* \\
#define Room Unthing
    grammar directionName(out): 'out' | 'outside':
   dir = outDirection
;

/* Speech */

DefineLiteralAction(Say)
    execAction
    {
        local literal = rexReplace(R'^%s+|%s+$', getLiteral().toLower(), '');
        if (literal is in ('xyzzy', 'plugh'))
            tryImplicitActionMsg(&silentImplicitAction, Xyzzy);
        else if (literal != key.keyword)
            "Nothing happens. ";
        else if (literal not in ())
        {
            if (gActor.location == portico && basin.isMirror)
            {
                local obscuringItem = basin.obscuringItem;
                if (obscuringItem)
                    "The air above the basin shimmers, and
                    <<obscuringItem.theName>> <<obscuringItem == bird ?
                    'ruffles its feathers in' : 'bobs on'>> the rippling water.
                    After a moment, the shimmering disappears. ";
                else
                {
                    /*
                     *   Venus qͥ la pꝛiere ouyt
                     *   [...]
                     *   A lymage ēuoya loꝛs lame.
                     *   Sı ꝺeuīt ſı treſbelle dame.
                     *   Quoncq̄s en toute la contree.
                     *   Not len ſı belle encontree.
                     *   [...]
                     *   Doulx amys aīs ſuy vꝛ̄e amye.
                     *   Pꝛeſte ꝺe voſtre compaıgnye.
                     *   Receuoır ⁊ mamoᷣ voꝰ offre.
                     *   Sıl voꝰ plaıſt receuoır tel offre.
                     *   [...]
                     *   Aux ꝺıeux eulx.ii.graces rēẟırēt.
                     *   Quı tel courtoıſıe leur fırent
                     *   Eſpecıalmant a venus.
                     *   Qui leᷣ ot ayꝺıe mieulx q̄ nulz.
                     *      (MS. Douce 195, fol. 151v–152r)
                     */
                    "The air above the basin shimmers for a moment. You hear
                    <<if door.isOpen()>>footsteps<<else>>the door <<if
                    door.isLocked>>being unlocked<<else>>opening<<end>><<end>>
                    behind you. Turning around, you see a
                    woman who looks remarkably like your statue.\b
                    <q>Hello, world,</q> she says. <q>It&rsquo;s nice to be
                    alive at last! Hello, dearest Pygmentalion.</q>\b
                    Ah, what beauty! What mastery of syntax! Praise be to
                    Aphrodite! ";
                    finishGameMsg(ftVictory,
                                  [finishOptionUndo, finishOptionFullScore]);
                }
            }
            else
                "Nothing happens. <<if keywordToken.scoreCount>>(Aphrodite said
                you would need a mirror.) <<end>>";
        }
    }
;

VerbRule(Say)
    ('say' | 'shout') singleLiteral
    : SayAction
    verbPhrase = 'say/saying (what)'
;

VerbRule(SayTo)
    ('say' | 'shout') singleLiteral ('at' | 'to') singleIobj
    : SayAction
    verbPhrase = 'say/saying (what) (to what)'
;

modify tryOops(
    tokList, issuingActor, targetActor, firstTokenIndex, cmdTokenList, cmdType)
{
    if (cmdTokenList.length() == 1)
    {
        local tokVal = rexReplace(
            R'^([`\'"\u2018\u201C]|%s)+|([`\'"\u2019\u201D]|%s)+$',
            getTokVal(cmdTokenList[1]).toLower(), '');
        if (tokVal == key.keyword)
        {
            throw new ReplacementCommandStringException(
                'say <<tokVal>>', nil, nil);
        }
    }
    return replaced(tokList, issuingActor, targetActor, firstTokenIndex,
        cmdTokenList, cmdType);
}

/**/ #if /* Revere the basileus. */ 0   \
         // Expel the barbarian.
;
 #ifndef __DEBUG
;
  #define __DEBUG
;
# else
;
#if 1
;
  #define DEBUG__
;
#endif
;
 #endif
;\\
#endif
/*
#endif
?*/
//\\
#endif
'''
#endif
'\''''
#endif
\\'''
"""
#endif
"\""""
#endif
\\"""
'
#endif
\'
#endif
\\'
"
#endif
\"
#endif
\\"
'''<<'<<'
#endif
'>>'>>
#endif
'''
"""<<'<<'
#endif
'>>'>>
#endif
"""
'<<'<<'
#endif
'>>'>>
#endif
'
"<<'<<'
#endif
'>>'>>
#endif
"//"
\
	#	endif
;
dictionary barbarianDict;
DefineIAction(Xyzzy)
    execAction
    {
        "Only a barbarian could pronounce such a word. ";
        local oldSay = t3SetSay({str : nil});
        try
        {
            new transient Vector([
                '<<one of>><< cycling >>',
                '<<one of>><<            at random>>',
                '<<one of>><<then purely at random>>',
                '<<one of>><<as decreasingly likely outcomes>>',
                '<<one of>><<          shuffled>>',
                '<<one of>><<     half shuffled>>',
                '<<one of>><<then      shuffled>>',
                '<<one of>><<then half shuffled>>']);
            '''''<font x= color=red bgcolor='silver' face="TADS-Sans"
            size=\'+1\' x=\"x\">{can't}</font>\'''' '' '''';
            """""<font x= color=red bgcolor='silver' face="TADS-Sans"
            size=\'+1\' x=\"x\">{can't}</font>\"""" "" """";
            '<font x= color=red face="TADS-Sans" size=\'+1\'
            x=\"x\">{can\'t}</font>\'';
            "<font x= color=red bgcolor='silver' size=\'+1\'
            x=\"x\">{can\'t}</font>\"";
            '''''<font <<'color=red'>> bgcolor<<'='>>silver
            face=<<'"TADS-Sans"'>>>{ca<<'n\''>>t}</font>\'''' '' '''';
            """""<font <<'color=red'>> bgcolor<<'='>>silver
            face=<<'"TADS-Sans"'>>>{ca<<'n\''>>t}</font>\"""" "" """";
            '<font <<'color=red'>> bgcolor<<'='>>silver
            face=<<'"TADS-Sans"'>>>{ca<<'n\''>>t}</font>\'';
            "<font <<'color=red'>> bgcolor<<'='>>silver
            face=<<'"TADS-Sans"'>>>{ca<<'n\''>>t}</font>\"";
            '''<s a1={\.}a a2=a{\>} a3=a{\>}a b1='{\>}b' b2='b{\>}' b3='b{\>}b'
            c1="c{\>}" c2="{\>}c" c3="c{\>}c" d1=\'d{\>}\' d2=\'{\>}d\'
            d3=\'d{\>}d\' e1=\"e{\>}\" e2=\"{\>}e\" e3=\"e{\>}e\"></s>''';
            """<s a1={\.}a a2=a{\>} a3=a{\>}a b1='{\>}b' b2='b{\>}' b3='b{\>}b'
            c1="c{\>}" c2="{\>}c" c3="c{\>}c" d1=\'d{\>}\' d2=\'{\>}d\'
            d3=\'d{\>}d\' e1=\"e{\>}\" e2=\"{\>}e\" e3=\"e{\>}e\"></s>""";
            '<s a1={\.}a a2=a{\>} a3=a{\>}a c1="c{\>}" c2="{\>}c" c3="c{\>}c"
            d1=\'d{\>}\' d2=\'{\>}d\' d3=\'d{\>}d\' e1=\"e{\>}\" e2=\"{\>}e\"
            e3=\"e{\>}e\"></s>';
            "<s a1={\.}a a2=a{\>} a3=a{\>}a b1='{\>}b' b2='b{\>}' b3='b{\>}b'
            d1=\'d{\>}\' d2=\'{\>}d\' d3=\'d{\>}d\' e1=\"e{\>}\" e2=\"{\>}e\"
            e3=\"e{\>}e\"></s>";
            '''{a<<1>>b}'''; """{a<<1>>b}"""; '{a<<1>>b}'; "{a<<1>>b}";
            '''<s a<<'='>>'1' b<<'='>>"2" c<<'='>>\'3\' d<<'='>>\"4\"
            <<'e'>>=5 f=6' g=7">''';
            """<s a<<'='>>'1' b<<'='>>"2" c<<'='>>\'3\' d<<'='>>\"4\"
            <<'e'>>=5 f=6' g=7">""";
            '<s b<<'='>>"2" c<<'='>>\'3\' d<<'='>>\"4\" <<'e'>>=5 g=7">';
            "<s a<<'='>>'1' c<<'='>>\'3\' d<<'='>>\"4\" <<'e'>>=5 f=6'>";
            '''<s a=v\\ a=v\ v\><s a='{'}'\><s a="{"}"\>''';
            """<s a=v\\ a=v\ v\><s a='{'}'\><s a="{"}"\>""";
            '<s a=v\\ a=v\ v\><s a=\'{\'}\'\><s a="{"}"\>';
            "<s a=v\\ a=v\ v\><s a='{'}'\><s a=\"{\"}\"\>";
            '''<font color='purple>igram</font>'''; '''<t a={'''; '''}''';
            '''<font color="purple>igram</font>'''; '''<t a='{'''; '''}''';
            '''<font color=\'purple>igram</font>'''; '''<t a="{'''; '''}''';
            '''<font color=\"purple>igram</font>''';
            """<font color='purple>igram</font>"""; """<t a={"""; """}""";
            """<font color="purple>igram</font>"""; """<t a='{"""; """}""";
            """<font color=\'purple>igram</font>"""; """<t a=\"{"""; """}""";
            """<font color=\"purple>igram</font>""";
            '<font color="purple>igram</font>'; '<t a={'; '}';
            '<font color=\'purple>igram</font>'; '<t a=\'{'; '}';
            '<font color=\"purple>igram</font>'; '<t a="{'; '}';
            "<font color=\"purple>igram</font>"; "<t a={"; "}";
            "<font color='purple>igram</font>"; "<t a='{"; "}";
            "<font color=\'purple>igram</font>"; "<t a=\"{"; "}\"";
            '''<xmp a=v>&amp;\x26<b><\xmp></xmp a=v>''';
            """<xmp a=v>&amp;\x26<b><\xmp></xmp a=v>""";
            '<xmp a=v>&amp;\x26<b><\xmp></xmp a=v>';
            "<xmp a=v>&amp;\x26<b><\xmp></xmp a=v>";
            '''<xmp a=v>&amp;\x26<b><\xmp><\Xmp a=v>''';
            """<xmp a=v>&amp;\x26<b><\xmp><\Xmp a=v>""";
            '<xmp a=v>&amp;\x26<b><\xmp><\Xmp a=v>';
            "<xmp a=v>&amp;\x26<b><\xmp><\Xmp a=v>";
            '''<xmp a=v>&amp;\x26<b><\xmp><\\xmp a=v>''';
            """<xmp a=v>&amp;\x26<b><\xmp><\\xmp a=v>""";
            '<xmp a=v>&amp;\x26<b><\xmp><\\xmp a=v>';
            "<xmp a=v>&amp;\x26<b><\xmp><\\xmp a=v>";
            '''<xmp>'''; """<xmp>"""; '<xmp>'; "<xmp>";
            '''<listing a=v>&amp;\x26<b><listing><xmp></listing a=v>''';
            """<listing a=v>&amp;\x26<b><listing><xmp></listing a=v>""";
            '<listing a=v>&amp;\x26<b><listing><xmp></listing a=v>';
            "<listing a=v>&amp;\x26<b><listing><xmp></listing a=v>";
            '''<listing a=v>&amp;\x26<b><listing><xmp><\listing a=v>''';
            """<listing a=v>&amp;\x26<b><listing><xmp><\listing a=v>""";
            '<listing a=v>&amp;\x26<b><listing><xmp><\listing a=v>';
            "<listing a=v>&amp;\x26<b><listing><xmp><\listing a=v>";
            '''<listing a=v>&amp;\x26<b><listing><xmp><\\listing a=v>''';
            """<listing a=v>&amp;\x26<b><listing><xmp><\\listing a=v>""";
            '<listing a=v>&amp;\x26<b><listing><xmp><\\listing a=v>';
            "<listing a=v>&amp;\x26<b><listing><xmp><\\listing a=v>";
            '''<listing>'''; """<listing>"""; '<listing>'; "<listing>";
        }
        finally
        {
            t3SetSay(oldSay);
        }
    }
;

VerbRule(Xyzzy)
    ("xyzzy" | "plugh") *
    : XyzzyAction
    verbPhrase = 'babble/talking like a barbarian'
;

#ifdef __DEBUG
VerbRule(ReciteLexicon)
    ('recite' ('the' |) |) 'lexicon'
    : ReciteLexiconAction
    verbPhrase = 'recite/reciting the lexicon'
;

DefineIAction(ReciteLexicon)
    protoWordPieceLists
    {
        local protoWordPieceLists = new Vector;
        greekWordGenerator.getWord(
            {lst: protoWordPieceLists.append(lst.getUnique().sort())},
            function(lst)
            {
                local ret = [];
                for (local x in lst)
                    ret += x;
                return ret;
            });
        return self.protoWordPieceLists = protoWordPieceLists.toList();
    }
    execAction
    {
        local indices = Vector.generate({i: 1}, protoWordPieceLists.length);
        gTranscript.deactivate();
        typographicalOutputFilter.deactivate();
        while (true)
        {
            local word = '';
            for (local i = 1; i <= indices.length; ++i)
            {
                word += protoWordPieceLists[i][indices[i]];
            }
            "<<word.toUpper>> &gt; ";
            word = greekWordGenerator.mutate(word);
            if (greekWordGenerator.isUnacceptableByPattern(word))
                "*";
            else if (greekWordGenerator.isBarelyAcceptable(word))
                "?";
            "<<word>>\n";
            flushOutput();
            local done = true;
            for (local i = indices.length; i >= 1; --i)
            {
                if (indices[i] < protoWordPieceLists[i].length)
                {
                    ++indices[i];
                    done = nil;
                    break;
                }
                else
                    indices[i] = 1;
            }
            if (done)
                break;
        }
        typographicalOutputFilter.activate();
        gTranscript.activate();
    }
;
#endif

function randListItem(lst)
{
    if (dataType(lst) != TypeList)
        return lst;
    return rand(lst);
}

greekWordGenerator: PreinitObject
    arrheta
    {
        local wordTable = new LookupTable();
        local resourceName = 'arrheta.txt';
        try
        {
            file = File.openTextResource(resourceName);
        } catch (FileException e) {
            return arrheta = wordTable;
        }
        file.setCharacterSet('utf-8');
        local word = nil;
        while ((word = file.readFile()) != nil)
        {
            word = word.findReplace('\n', '', ReplaceOnce);
            local key = word.substr(1, 3);
            if (!wordTable.isKeyPresent(key))
                wordTable[key] = new Vector();
            wordTable[key] += word;
        }
        return arrheta = wordTable;
    }
    isArrheton(word)
    {
        local subsection = arrheta[word.substr(1, 3)];
        return subsection != nil && subsection.indexOf(word) != nil;
    }
    vowels = ['a', 'e', 'e', 'i', 'o', 'y', 'o']
    semivowels = ['','', 'i', 'u']
    breathings = ['', 'h']
    prefixes = ['', 'b', 'g', 'd', 'k', 'm', 'p', 's', 't']
    consonants = prefixes - '' + ['l', 'n', 'r']
    onsets = ['bl', 'br', 'kl', 'kn', 'kr', 'pl', 'pn', 'pr', 'tm', 'tr']
    codas = consonants - ['b', 'g', 'd']
    suffixes = ['', 's']
    retries = nil
    execute
    {
        local retries = 0;
        for (local r in 0 .. -1 step -1)
        {
            for ((r), local i = 0, local j = 2; i < j; ++i, --j)
            {
                for (local s = 0, local n in [90, 30, 10]; ; --s)
                    retries -= s * n;
            }
        }
        retries *= 2;
        retries >>= 1;
        retries /= 2;
        retries <<= 1;
        retries >>>= 2;
        retries %= 16;
        retries &= ~1;
        retries |= 2;
        retries ^= retries ^ retries;
        self.retries = retries;
    }
    generate()
    {
        local word;
        local retries = self.retries;
        do
        {
            word = mutate(randomProtoWord);
        } while (retries-- && isBarelyAcceptable(word)
            || isUnacceptable(word));
        cmdDict.addWord(self, word, &noun);
        return word;
    }
    getWord(choose, fromList)
    {
        local ret = choose(fromList(prefixes));
        for (local i in 0 .. __TADS3)
        {
            ret += choose(fromList(fromList([[''], onsets, consonants])));
            ret += choose(fromList(breathings));
            ret += choose(fromList(vowels));
            ret += choose(fromList(semivowels + fromList(codas)));
        }
        ret += choose(fromList(suffixes));
        return ret;
    }
    randomProtoWord = (getWord(randListItem, randListItem))
    mutate(word)
    {
        word = rexReplace(R'^sb', word, 'sp');
        word = rexReplace(R'^sg', word, 'sk');
        word =
            rexReplace(R'^[pk](?![tsnlrhaeioy]|[tsnlr]h?[^aeioy])', word, '');
        word = rexReplace(R'^b(?![dlrhaeioy]|[dlr]h?[^aeioy])', word, '');
        word = rexReplace(R'^g(?![nlrhaeioy]|[nlr]h?[^aeioy])', word, '');
        word = rexReplace(R'^t(?![mrhaeioy]|[mlr]h?[^aeioy])', word, '');
        word = rexReplace(R'^d(?![rhaeioy]|rh?[^aeioy])', word, '');
        word = rexReplace(R'^m(?![nhaeioy]|nh?[^aeioy])', word, '');
        word = rexReplace(R'^[^aeioy]h?(([^haeioy]h?){2})', word, '%1');
        word = rexReplace(R'[ptkbdgs]([ptkbdg][^haeioy])', word, '%1');
        word = rexReplace(R'([mnlr])h', word, 'h%1');
        word = rexReplace(R'(?<!(^|[ptk]))h', word, '');
        word = rexReplace(R'^h(?![aeioy])', word, '');
        word = rexReplace(R'h(?=.*h)', word, '');
        word = rexReplace(R'^phn', word, 'pn');
        word = rexReplace(R'(?<=^|r)r', word, 'rh');
        word = rexReplace(R'([iy]+)[iu]', word, '%1');
        word = rexReplace(R'nl', word, 'll');
        word = rexReplace(R'n(?=[pbm])', word, 'm');
        word = rexReplace(R'(?<.)m(?=[tdn])', word, 'n');
        word = rexReplace(R'pb|bp', word, 'pp');
        word = rexReplace(R'td|dt', word, 'tt');
        word = rexReplace(R'kg|gk', word, 'kk');
        word = rexReplace(R'bs', word, 'ps');
        word = rexReplace(R'ds|sd', word, 'z');
        word = rexReplace(R'gs', word, 'ks');
        word = rexReplace(R'ts', word, 'ss');
        word = rexReplace(R'[^pkaeioyusnr]+(s?)$', word, '%1');
        word = rexReplace(R'[pk]+$', word, '');
        word = rexReplace(R'(n|r)s+$', word, '%1');
        word = rexReplace(R'(.h?)%1{2,}', word, '%1%1');
        word = rexReplace(R'^(.h?)%1', word, '%1');
        word = rexReplace(R'(.h?)%1$', word, '%1');
        word = rexReplace(R'^y', word, 'hy');
        word = rexReplace(R'([ptk])([ptk])h', word, '%1h%2h');
        word = rexReplace(R'([ptk])h%1h', word, '%1%1h');
        word = rexReplace(R'ks', word, 'x');
        word = rexReplace(R'gg', word, 'kg');
        word = rexReplace(R'kh', word, 'ch');
        return word;
    }
    isBarelyAcceptable(word)
    {
        return word.length < 4 || !rexSearch(
            new RexPattern(
                '^(eu|hy|[pgm]n|ps|x|bd|tm|rh)|(.h.|pp|kc|rr)h|ch([^aeioy])|'
                + '([^aeiouy])y([^aeioy])$|(ps|x|o[ius])$'),
            word);
    }
    isUnacceptable(word)
    {
        return cmdDict.isWordDefined(word)
            || isArrheton(word)
            || isUnacceptableByPattern(word);
    }
    isUnacceptableByPattern(word)
    {
        return rexSearch(R'[aeiou](ie|y)|ee|o[ao]|y[aeioy]|y$|u[aeo]u', word)
            != nil;
    }
;
