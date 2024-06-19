USE master;
GO
DECLARE @Exists INT;

-- Check if the database already exists
SELECT @Exists = COUNT(*)
FROM sys.databases
WHERE name = 'BookDatabase';

IF @Exists > 0
BEGIN
  -- If database exists, drop it gracefully with NO WAIT option
  ALTER DATABASE BookDatabase SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
  DROP DATABASE BookDatabase;
END;

CREATE DATABASE BookDatabase;
GO

USE BookDatabase;
GO

-- Create the Genres table
CREATE TABLE Genres(
    id VARCHAR(255) PRIMARY KEY,
    genre VARCHAR(255)
);

-- Create the Products table
CREATE TABLE Products(
    id VARCHAR(255) PRIMARY KEY,
    title VARCHAR(MAX),
    author VARCHAR(MAX),
    genreId VARCHAR(255) REFERENCES Genres(id),
    price FLOAT,
    quantity INT,
    authorInformation VARCHAR(MAX),
    publicationDate VARCHAR(MAX),
    bookDescription VARCHAR(MAX),
    imagePath VARCHAR(MAX),
    rating FLOAT
);

-- Create the Accounts table
CREATE TABLE Accounts(
    name VARCHAR(MAX),
    phone VARCHAR(10),
    address VARCHAR(MAX),
    email VARCHAR(MAX),
    username VARCHAR(255) PRIMARY KEY,
    password VARCHAR(MAX),
    isAdmin BIT
);

-- Create the Cart table
CREATE TABLE Cart(
    id INT IDENTITY(1,1) PRIMARY KEY,
    username VARCHAR(255) FOREIGN KEY REFERENCES Accounts(username),
    productId VARCHAR(255) FOREIGN KEY REFERENCES Products(id),
    quantity INT
);

-- Create the Orders table
CREATE TABLE [Orders](
    id INT PRIMARY KEY,
    date DATE NULL,
    username VARCHAR(255) FOREIGN KEY REFERENCES Accounts(username),
    status VARCHAR(255)
);

-- Create the OrderDetails table
CREATE TABLE OrderDetails(
    id INT IDENTITY(1,1) PRIMARY KEY,
    orderId INT FOREIGN KEY REFERENCES Orders(id),
    productId VARCHAR(255) FOREIGN KEY REFERENCES Products(id),
    [Quantity] INT NULL
);
GO

-- Create the trigger for AFTER INSERT on OrderDetails
CREATE TRIGGER trg_OrderDetails_Insert
ON OrderDetails
AFTER INSERT
AS
BEGIN
    -- Update the quantity in Products table
    UPDATE Products
    SET quantity = p.quantity - i.Quantity
    FROM Products p
    JOIN inserted i ON p.id = i.productId
    JOIN Orders o ON i.orderId = o.id
    WHERE o.status <> 'cancelled'
END;
GO

-- Create the trigger for AFTER UPDATE on Orders to handle status changes
CREATE TRIGGER trg_Orders_Update
ON Orders
AFTER UPDATE
AS
BEGIN
    -- Check if the status is updated to 'cancelled'
    IF UPDATE(status)
    BEGIN
        -- Recover the quantity in Products table for cancelled orders
        UPDATE Products
        SET quantity = p.quantity + od.Quantity
        FROM Products p
        JOIN OrderDetails od ON p.id = od.productId
        JOIN inserted i ON od.orderId = i.id
        WHERE i.status = 'cancelled';
    END
END;
GO



insert into Accounts values('Tram Anh', '0975571434', 'Hanoi', 'anh@gmail.com', 'tramanh', '123', 1)
insert into Accounts values('Customer', '987654321', 'HCM City', 'customer@gmail.com', 'customer', '123', 0)

INSERT INTO Genres VALUES('fiction', 'Fiction')
INSERT INTO Genres VALUES('mystery', 'Mystery')
INSERT INTO Genres VALUES('historical-fiction', 'Historical Fiction')
INSERT INTO Genres VALUES('fantasy', 'Fantasy')
INSERT INTO Genres VALUES('romance', 'Romance')
INSERT INTO Genres VALUES('science-fiction', 'Science Fiction')
INSERT INTO Genres VALUES('horror', 'Horror')
INSERT INTO Genres VALUES('short-stories', 'Short Stories')
INSERT INTO Genres VALUES('nonfiction', 'Nonfiction')
INSERT INTO Genres VALUES('memoir', 'Memoir')--
INSERT INTO Genres VALUES('graphic-novels', 'Graphic Novels')
INSERT INTO Genres VALUES('poetry', 'Poetry')--
INSERT INTO Genres VALUES('young-adult', 'Young Adult')
INSERT INTO Genres VALUES('picture-books', 'Picture Books')
--INSERT INTO Genres VALUES('dark', 'Dark')--
-- INSERT INTO Genres VALUES('buddhism', 'Buddhism')--
INSERT INTO Genres VALUES('history', 'History')--
INSERT INTO Genres VALUES('science', 'Science')--
INSERT INTO Genres VALUES('cookbooks', 'Cookbooks')--
-- INSERT INTO Genres VALUES('comics', 'Comics')--
INSERT INTO Genres VALUES('middle-grade', 'Middle Grade')
INSERT INTO Genres VALUES('thriller', 'Thriller')--
-- INSERT INTO Genres VALUES('christian', 'Christian')--
-- INSERT INTO Genres VALUES('productivity', 'Productivity')--


INSERT INTO products VALUES ('42346406', 'One Two Three', 'Laurie Frankel', 'fiction', 11.99, 3, 'Laurie Frankel is the bestselling author of five novels: FAMILY FAMILY, coming 1/23/24, as well as ONE TWO THREE, THIS IS HOW IT ALWAYS IS, GOODBYE FOR NOW, and THE ATLAS OF LOVE. She lives with her family on a very steep hill in Seattle, but she''s an east coaster at heart. She is also a baseball fan, a soup maker, a theater lover, a yoga practicer, a comma expert, and a huge reader (just like you).', 'June 8, 2021', 'In a town where nothing ever changes, suddenly everything does...

Everyone knows everyone in the tiny town of Bourne, but the Mitchell triplets are especially beloved. Mirabel is the smartest person anyone knows, and no one doubts it just because she can’t speak. Monday is the town’s purveyor of books now that the library’s closed―tell her the book you think you want, and she’ll pull the one you actually do from the microwave or her sock drawer. Mab’s job is hardest of all: get good grades, get into college, get out of Bourne.

For a few weeks seventeen years ago, Bourne was national news when its water turned green. The girls have come of age watching their mother’s endless fight for justice. But just when it seems life might go on the same forever, the first moving truck anyone’s seen in years pulls up and unloads new residents and old secrets. Soon, the Mitchell sisters are taking on a system stacked against them and uncovering mysteries buried longer than they’ve been alive. Because it''s hard to let go of the past when the past won''t let go of you.

Three unforgettable narrators join together here to tell a spellbinding story with wit, wonder, and deep affection. As she did in , Laurie Frankel has written a laugh-out-loud-on-one-page-grab-a-tissue-the-next novel, as only she can, about how expanding our notions of normal makes the world a better place for everyone and how when days are darkest, it’s our daughters who will save us all.', 'one-two-three.jpg', 3.88)
INSERT INTO products VALUES ('57505278', 'All Her Little Secrets', 'Wanda M. Morris', 'mystery', 1.99, 2, 'Wanda M. Morris is a corporate attorney, having worked in the legal departments of some of America''s top Fortune 100 companies. As an accomplished presenter and leader, she previously served as President of the Georgia Chapter of the Association of Corporate Counsel, in which she established a signature female empowerment program known as the Women''s Initiative.

Wanda M. Morris is an alumni of the Yale Writers Workshop and a Claymore Award finalist for mystery writing. She is a member of Sisters in Crime and Mystery Writers of America. She is married, the mother of three, and she lives in Atlanta, Georgia.', 'November 2, 2021', 'In this fast-paced thriller, Wanda M. Morris crafts a twisty mystery about a black lawyer who gets in over her head after the sudden death of her boss. A debut perfect for fans of Attica Locke, Alyssa Cole, Harlan Coben, and Celeste Ng, with shades of How to Get Away with Murder and John Grisham’s The Firm.

Everyone has something to hide...

Ellice Littlejohn seemingly has it all: an Ivy League law degree, a well-paying job as a corporate attorney in midtown Atlanta, great friends, and a “for fun” relationship with a rich, charming executive—her white boss, Michael.

But everything changes one cold January morning when Ellice goes to meet Michael… and finds him dead with a gunshot to his head.

And then she walks away like nothing has happened. Why? Ellice has been keeping a cache of dark secrets, including a small-town past and a kid brother who’s spent time on the other side of the law. She can’t be thrust into the spotlight—.

But instead of grieving this tragedy, people are gossiping, the police are getting suspicious, and Ellice, the company’s lone black attorney, is promoted to replace Michael. While the opportunity is a dream-come-true, Ellice just can’t shake the feeling that something is off.

When she uncovers shady dealings inside the company, Ellice is trapped in an impossible ethical and moral dilemma. Suddenly, Ellice’s past and present lives collide as she launches into a pulse-pounding race to protect the brother she tried to save years ago and stop a conspiracy far more sinister than she could have ever imagined…', 'all-her-little-secrets.jpg', 3.69)
INSERT INTO products VALUES ('54404602', 'The Sweetness of Water', 'Nathan Harris', 'historical-fiction', 11.99, 21, '', 'June 15, 2021', 'In the spirit of The Known World and The Underground Railroad, a profound debut about the unlikely bond between two freedmen who are brothers and the Georgia farmer whose alliance will alter their lives, and his, forever.

In the waning days of the Civil War, brothers Prentiss and Landry—freed by the Emancipation Proclamation—seek refuge on the homestead of George Walker and his wife, Isabelle. The Walkers, wracked by the loss of their only son to the war, hire the brothers to work their farm, hoping through an unexpected friendship to stanch their grief. Prentiss and Landry, meanwhile, plan to save money for the journey north and a chance to reunite with their mother, who was sold away when they were boys.

Parallel to their story runs a forbidden romance between two Confederate soldiers. The young men, recently returned from the war to the town of Old Ox, hold their trysts in the woods. But when their secret is discovered, the resulting chaos unleashes convulsive repercussions on the entire community. In the aftermath of so much turmoil, it is Isabelle who emerges as an unlikely leader, proffering a healing vision for the land and for the newly free citizens of Old Ox.

With candor and sympathy, debut novelist Nathan Harris creates an unforgettable cast of characters, depicting Georgia in the violent crucible of Reconstruction. Equal parts beauty and terror, as gripping as it is moving, is an epic whose grandeur locates humanity and love amid the most harrowing circumstances.', 'the-sweetness-of-water.jpg', 4.16)
INSERT INTO products VALUES ('54467051', 'The Unbroken', 'C.L. Clark', 'fantasy', 4.99, 60, 'C.L. Clark is a BFA award-winning editor and Ignyte award winning-writer, and the author of Nebula-nominated novel The Unbroken, the first book in the Magic of the Lost trilogy. She graduated from Indiana University’s creative writing MFA and was a 2012 Lambda Literary Fellow. She’s been a personal trainer, an English teacher, and an editor, and is some combination thereof as she travels the world. When she’s not writing or working, she’s learning languages, doing P90something, or reading about war and [post-]colonial history. Her work has appeared in various SFF venues, including Tor.com, Uncanny, and Beneath Ceaseless Skies.', 'March 23, 2021', 'Alternate Cover edition for ISBN 9780316542753

Touraine is a soldier. Stolen as a child and raised to kill and die for the empire, her only loyalty is to her fellow conscripts. But now, her company has been sent back to her homeland to stop a rebellion, and the ties of blood may be stronger than she thought.

Luca needs a turncoat. Someone desperate enough to tiptoe the bayonet''s edge between treason and orders. Someone who can sway the rebels toward peace, while Luca focuses on what really matters: getting her uncle off her throne.

Through assassinations and massacres, in bedrooms and war rooms, Touraine and Luca will haggle over the price of a nation. But some things aren''t for sale.', 'the-unbroken.jpg', 3.83)
INSERT INTO products VALUES ('52057698', 'How to Fail at Flirting', 'Denise Williams', 'romance', 7.99, 45, '', 'December 1, 2020', 'One daring to-do list and a crash course in flirtation turn a Type A overachiever’s world upside down.

When her flailing department lands on the university''s chopping block, Professor Naya Turner’s friends convince her to shed her frumpy cardigan for an evening on the town. For one night her focus will stray from her demanding job and she’ll tackle a new kind of to-do list. When she meets a charming stranger in town on business, he presents the perfect opportunity to check off the items on her list. Let the guy buy her a drink. Check. Try something new. Check. A no-strings-attached hookup. Check…almost.

Jake makes her laugh and challenges Naya to rebuild her confidence, which was left toppled by her abusive ex-boyfriend. Soon she’s flirting with the chance at a more serious romantic relationship—except nothing can be that easy. The complicated strings around her dating Jake might destroy her career.

Naya has two options. She can protect her professional reputation and return to her old life or she can flirt with the unknown and stay with the person who makes her feel like she''s finally living again.', 'how-to-fail-at-flirting.jpg', 3.80)
INSERT INTO products VALUES ('54304067', 'Machinehood', 'S.B. Divya', 'science-fiction', 13.99, 88, 'S.B. Divya (she/any) is a lover of science, math, fiction, and the Oxford comma. She is the Hugo and Nebula nominated author of Meru (2023), Machinehood, Runtime, and Contingency Plans For the Apocalypse and Other Possible Situations. Her short stories have appeared in numerous magazines and anthologies, and she was the co-editor of Escape Pod, the weekly science fiction podcast, from 2017-2022. Divya holds degrees in Computational Neuroscience and Signal Processing, and she worked for twenty years as an electrical engineer before becoming an author. Born in Pondicherry, India, Divya now resides in Southern California. She enjoys subverting expectations and breaking stereotypes whenever she can.', 'March 2, 2021', 'A science fiction thriller about artificial intelligence, sentience, and labor rights in a near future dominated by the gig economy.

Welga Ramirez, executive bodyguard and ex-special forces, is about to retire early when her client is killed in front of her. It’s 2095 and people don’t usually die from violence. Humanity is entirely dependent on pills that not only help them stay alive, but allow them to compete with artificial intelligence in an increasingly competitive gig economy. Daily doses protect against designer diseases, flow enhances focus, zips and buffs enhance physical strength and speed, and juvers speed the healing process.

All that changes when Welga’s client is killed by The Machinehood, a new and mysterious terrorist group that has simultaneously attacked several major pill funders. The Machinehood operatives seem to be part human, part machine, something the world has never seen. They issue an ultimatum: stop all pill production in one week.

Global panic ensues as pill production slows and many become ill. Thousands destroy their bots in fear of a strong AI takeover. But the US government believes the Machinehood is a cover for an old enemy. One that Welga is uniquely qualified to fight.

Welga, determined to take down the Machinehood, is pulled back into intelligence work by the government that betrayed her. But who are the Machinehood and what do they really want?

A thought-provoking novel that asks: if we won’t see machines as human, will we instead see humans as machines?', 'machinehood.jpg', 3.64)
INSERT INTO products VALUES ('55540151', 'Where They Wait', 'Scott Carson', 'horror', 9.99, 76, 'Scott Carson is the pen name of Michael Koryta, a New York Times bestselling author whose work has been translated into more than twenty languages, adapted into major motion pictures, and won the Los Angeles Times Book Prize. A former private investigator and reporter, his writing has been praised by Stephen King, Michael Connelly, and Dean Koontz, among many others. Raised in Bloomington, Indiana, he now lives in Indiana and Maine.', 'October 26, 2021', 'Recently laid-off from his newspaper and desperate for work, war correspondent Nick Bishop takes a humbling job: writing a profile of a new mindfulness app called Clarity. It’s easy money, and a chance to return to his hometown for the first time in years. The app itself seems like a retread of old ideas—relaxing white noise and guided meditations.

But then there are the “Sleep Songs.” A woman’s hauntingly beautiful voice sings a ballad that is anything but soothing—it’s disturbing, and more of a warning than a relaxation—but it works. Deep, refreshing sleep follows.

So do the nightmares. Vivid and chilling, they feature a dead woman who calls Nick by name and whispers guidance—or are they threats? And her voice follows him long after the song is done. As the effects of the nightmares begin to permeate his waking life, Nick makes a terrifying discovery: no one involved with has any interest in his article. Their interest is in .', 'where-they-wait.jpg', 3.62)
INSERT INTO products VALUES ('56257258', 'Big Time', 'Jen Spyra', 'short-stories', 7.99, 85, '', 'March 16, 2021', 'The debut collection of raucous, dark, strange, satirical stories from the former ''Late Show with Stephen Colbert'' writer and ''New Yorker'' contributor, featuring a foreword by Stephen Colbert

A bride so desperate to get in shape for her wedding that she enrolls in a new kind of workout program that promises the moon but costs more than she bargained for. A snowman who, on the wish of a child, comes to life in a decidedly less savory way than in the childhood classic. And in the title story, a time-hopping 1940s starlet tries to claw her way to the top in modern-day Hollywood, despite being ridiculously unwoke.

In this uproarious, addictive debut, Jen Spyra takes a culture that seems almost beyond parody and holds it up to a funhouse mirror, immersing the reader in a world of prehistoric influencers, woodland creatures plagued by millennial neuroses, and an all-out birthday bash determined to be the most lavish celebration of all time, by any means necessary.

Welcome, brave soul, to the world of Jen Spyra.', 'big-time.jpg', 3.46)
INSERT INTO products VALUES ('54814834', 'Under a White Sky: The Nature of the Future', 'Elizabeth Kolbert', 'nonfiction', 13.99, 50, 'Elizabeth Kolbert is a staff writer at The New Yorker. She is the author of Field Notes from a Catastrophe: Man, Nature, and Climate Change and The Sixth Extinction: An Unnatural History. She lives in Williamstown, Massachusetts, with her husband and children.', 'February 9, 2021', 'The Pulitzer Prize–winning author of The Sixth Extinction returns to humanity’s transformative impact on the environment, now asking: After doing so much damage, can we change nature, this time to save it?

That man should have dominion “over all the earth, and over every creeping thing that creepeth upon the earth” is a prophecy that has hardened into fact. So pervasive are human impacts on the planet that it’s said we live in a new geological epoch: the Anthropocene.

In Elizabeth Kolbert takes a hard look at the new world we are creating. She meets scientists who are trying to preserve the world’s rarest fish, which lives in a single, tiny pool in the middle of the Mojave. She visits a lava field in Iceland, where engineers are turning carbon emissions to stone; an aquarium in Australia, where researchers are trying to develop “super coral” that can survive on a hotter globe; and a lab at Harvard, where physicists are contemplating shooting tiny diamonds into the stratosphere in order to reflect sunlight back to space and cool the earth.

One way to look at human civilization, says Kolbert, is as a ten-thousand-year exercise in defying nature. In she explored the ways in which our capacity for destruction has reshaped the natural world. Now she examines how the very sorts of interventions that have imperiled our planet are increasingly seen as the only hope for its salvation. By turns inspiring, terrifying, and darkly comic, is an utterly original examination of the challenges we face.', 'under-a-white-sky.jpg', 4.10)
INSERT INTO products VALUES ('55710553', 'House of Sticks', 'Ly Tran', 'Memoir', 0.00, 0, 'LY TRAN has received fellowships from MacDowell, Art Omi, Yaddo, and Millay Arts. House of Sticks is her first book.', 'June 1, 2021', 'New York City Book Awards Hornblower Award Winner

One of Vogue and NPR’s Best Books of the Year

This beautifully written “masterclass in memoir” ( Elle ) recounts a young girl ’ s journey from war-torn Vietnam to Queens, New York, “showcas[ing] the tremendous power we have to alter the fates of others, step into their lives and shift the odds in favor of greater opportunity” ( Star Tribune , Minneapolis).

Ly Tran is just a toddler in 1993 when she and her family immigrate from a small town along the Mekong river in Vietnam to a two-bedroom railroad apartment in Queens. Ly’s father, a former lieutenant in the South Vietnamese army, spent nearly a decade as a POW, and their resettlement is made possible through a humanitarian program run by the US government. Soon after they arrive, Ly joins her parents and three older brothers sewing ties and cummerbunds piece-meal on their living room floor to make ends meet.

As they navigate this new landscape, Ly finds herself torn between two worlds. She knows she must honor her parents’ Buddhist faith and contribute to the family livelihood, working long hours at home and eventually as a manicurist alongside her mother at a nail salon in Brooklyn that her parents take over. But at school, Ly feels the mounting pressure to blend in.

A growing inability to see the blackboard presents new challenges, especially when her father forbids her from getting glasses, calling her diagnosis of poor vision a government conspiracy. His frightening temper and paranoia leave a mark on Ly’s sense of self. Who is she outside of everything her family expects of her?

An “unsentimental yet deeply moving examination of filial bond, displacement, war trauma, and poverty” (NPR), House of Sticks is a timely and powerful portrait of one girl’s coming-of-age and struggle to find her voice amid clashing cultural expectations.', 'house-of-sticks.jpg', 4.38)
INSERT INTO products VALUES ('55057586', 'Zero Fail: The Rise and Fall of the Secret Service', 'Carol Leonnig', 'nonfiction', 9.99, 44, 'Carol Duhurst Leonnig is an American investigative journalist and a longtime staff writer for The Washington Post. She was part of a team of national security reporters that won the Pulitzer Prize for Public Service in 2014 for reporting that revealed the NSA''s expanded spying on Americans. She later received Pulitzers for National Reporting in 2015 and 2018. She is a member of the ''87 class at Bryn Mawr College', 'May 11, 2021', 'The first definitive account of the rise and fall of the Secret Service, from the Kennedy assassination to the ongoing scandals under Obama and Trump--by Pulitzer Prize winner and #1 New York Times bestselling co-author of A Very Stable Genius

Carol Leonnig has been covering the Secret Service for The Washington Post for most of the last decade, bringing to light the gaffes and scandals that plague the agency today--from a toxic work culture to outdated equipment and training to the deep resentment among the ranks with the agency''s leadership. But the Secret Service wasn''t always so troubled.

The Secret Service was born in 1865, in the wake of the assassination of Abraham Lincoln, but its story begins in earnest in 1963, with the death of John F. Kennedy. Shocked into reform by their failure to protect the president on that fateful day, this once-sleepy agency was rapidly transformed into a proud, elite unit that would finally redeem themselves in 1981 by valiantly thwarting an assassination attempt against Ronald Reagan. But this reputation for courage and efficiency would not last forever. By Barack Obama''s presidency, the Secret Service was becoming notorious for break-ins at the White House, an armed gunman firing at the building while agents stood by, a massive prostitution scandal in Cartagena, and many other dangerous lapses.

To expose the these shortcomings, Leonnig interviewed countless current and former agents who risked their careers to speak out about an agency that''s broken and in desperate need of a reform.', 'zero-fail.jpg', 4.24)
INSERT INTO products VALUES ('55284968', 'Bubble', 'Jordan Morris', 'graphic-novels', 12.99, 39, 'Hello! I''m a writer of television, features, podcast and COMICS! I''m the creator and co-writer of the 2x Eisner nominated graphic novel "Bubble." My next graphic novel with artist Bowen McCurdy is out 7/16/24! It''s a YA horror-comedy about teenage exorcists and I''m SO EXCITED for folks to see it. Please give it a "want to read" on here and a pre-order wherever you get your books!

You might also know me as the actor behind many unpleasant characters on "Good Mythical Morning" or the co-host of the not-super-popular but long-running podcast "Jordan Jesse Go!"', 'July 13, 2021', '(From the publisher''s website)

Based on the smash-hit audio serial, Bubble is a hilarious high-energy graphic novel with a satirical take on the “gig economy.”

Built and maintained by corporate benevolence, the city of Fairhaven is a literal bubble of safety and order (and amazing coffee) in the midst of the Brush, a harsh alien wilderness ruled by monstrous Imps and rogue bands of humans. Humans like Morgan, who’s Brush-born and Bubble-raised and fully capable of fending off an Imp attack during her morning jog. She’s got a great routine going—she has a chill day job, she recreationally kills the occasional Imp, then she takes that Imp home for her roommate and BFF, Annie, to transform into drugs as a side hustle. But cracks appear in her tidy life when one of those Imps nearly murders a delivery guy in her apartment, accidentally transforming him into a Brush-powered mutant in the process. And when Morgan’s company launches Huntr, a gig economy app for Imp extermination, she finds herself press-ganged into kicking her stabby side job up to the next level as she battles a parade of monsters and monstrously Brush-turned citizens, from a living hipster beard to a book club hive mind.', 'bubble.jpg', 4.01)
INSERT INTO products VALUES ('53398748', 'God I Feel Modern Tonight: Poems from a Gal About Town', 'Catherine Cohen', 'Poetry', 6.99, 66, '', 'February 2, 2021', 'Poems of heartbreak and sex, self-care and self-critique, urban adventures and love on the road from the millennial quarantine queen and comedy sensation.

in L.A. we got naked and swam in the ocean
we ate cured meats and carrots
& sat in the back of a red pickup truck
like we were in a film where two old friends fight
& wrestle their way into a hug
heave-sobbing as the dust settles
I want to be famous for being the first person
who never feels bad again

In these short, captivating lyrics, Catherine Cohen, the one-woman stand-up chanteuse who electrified the downtown NYC comedy scene in her white go-go boots, and who has been posting poignant, unfiltered poems on social media since before Instagram was a thing, details her life on the prowl with her beaded bag; she ponders guys who call you dude after sex, true love during the pandemic, and English-major dreams. I wish I were smart instead of on my phone, Cat Cohen confides; heartbreak, / when it comes, and it will come / is always new. A Dorothy Parker for our time, a Starbucks philosophe with no primary-care doctor, she''s a welcome new breed of everywoman--a larger-than-life best friend, who will say all the outrageous things we think but never say out loud ourselves.', 'god-i-feel-modern-tonight.jpg', 3.67)
INSERT INTO products VALUES ('53597769', 'The Five Wounds', 'Kirstin Valdez Quade', 'fiction', 9.99, 72, 'Kirstin Valdez Quade is the author of The Five Wounds and Night at the Fiestas, winner of the National Book Critics Circle’s John Leonard Prize. She is the recipient of a “5 Under 35” award from the National Book Foundation, the Rome Prize, and the Rona Jaffe Foundation Writer’s Award. Her work has appeared in The New Yorker, New York Times, The Best American Short Stories, The O. Henry Prize Stories, and elsewhere. Originally from New Mexico, she now lives in New Jersey and teaches at Princeton University.', 'April 6, 2021', 'From an award-winning storyteller comes a stunning debut novel about a New Mexican family’s extraordinary year of love and sacrifice.

It’s Holy Week in the small town of Las Penas, New Mexico, and thirty-three-year-old unemployed Amadeo Padilla has been given the part of Jesus in the Good Friday procession. He is preparing feverishly for this role when his fifteen-year-old daughter Angel shows up pregnant on his doorstep and disrupts his plans for personal redemption. With weeks to go until her due date, tough, ebullient Angel has fled her mother’s house, setting her life on a startling new path.

Vivid, tender, funny, and beautifully rendered, spans the baby’s first year as five generations of the Padilla family converge: Amadeo’s mother, Yolanda, reeling from a recent discovery; Angel’s mother, Marissa, whom Angel isn’t speaking to; and disapproving Tíve, Yolanda’s uncle and keeper of the family’s history. Each brings expectations that Amadeo, who often solves his problems with a beer in his hand, doesn’t think he can live up to.

is a miraculous debut novel from a writer whose stories have been hailed as “legitimate masterpieces” (). Kirstin Valdez Quade conjures characters that will linger long after the final page, bringing to life their struggles to parent children they may not be equipped to save.', 'the-five-wounds.jpg', 4.14)
INSERT INTO products VALUES ('53138093', 'The Project', 'Courtney Summers', 'young-adult', 9.99, 69, 'Courtney Summers is the author of several novels, including the breakout hit Sadie, which appeared on over 30 ‘Best of’ lists and was published in 26 territories. In 2018, Electric Literature proclaimed her “a master of the bitch” for her years of writing “nuanced, wrenching stories about angry [and] unlikable girls.” Her work has been released to critical acclaim, multiple starred reviews and has received numerous awards and honors, including the Edgar Award and the Odyssey Award. Courtney has reviewed for The and is the founder of the 2015 worldwide trending hashtag #ToTheGirls. She lives and writes in Canada. You can follow her on and .', 'February 2, 2021', 'Lo Denham is used to being on her own. After her parents died in a tragic car accident, her sister Bea joined the elusive community called The Unity Project, leaving Lo to fend for herself. Desperate not to lose the only family she has left, Lo has spent the last six years trying to reconnect with Bea, only to be met with radio silence.

When Lo’s given the perfect opportunity to gain access to Bea’s reclusive life, she thinks they’re finally going to be reunited. But it’s difficult to find someone who doesn’t want to be found, and as Lo delves deeper into The Project and its charismatic leader, she begins to realize that there’s more at risk than just her relationship with Bea: her very life might be in danger.

As she uncovers more questions than answers at each turn, everything Lo thought she knew about herself, her sister, and the world is upended. One thing doesn’t change, though, and that’s what keeps her going: Bea needs her, and Lo will do anything to save her.

From Courtney Summers, the bestselling author of the 2019 Edgar Award Winner and breakout hit , comes her electrifying follow-up—a suspenseful, pulls-no-punches story about an aspiring young journalist determined to save her sister no matter the cost.', 'the-project.jpg', 3.51)
INSERT INTO products VALUES ('53138253', 'A Vow So Bold and Deadly', 'Brigid Kemmerer', 'fantasy', 7.38, 55, 'Brigid Kemmerer is the New York Times bestselling author of dark and alluring YA novels like A Curse So Dark and Lonely, Defy the Night, and Letters to the Lost. A full time writer, Brigid lives in the Baltimore area with her family. When she’s not writing or being a mom, you can usually find her with her hands wrapped around a barbell.', 'January 26, 2021', 'Face your fears, fight the battle.

Emberfall is crumbling fast, torn between those who believe Rhen is the rightful prince and those who are eager to begin a new era under Grey, the true heir. Grey has agreed to wait two months before attacking Emberfall, and in that time, Rhen has turned away from everyone—even Harper, as she desperately tries to help him find a path to peace.

Fight the battle, save the kingdom.

Meanwhile, Lia Mara struggles to rule Syhl Shallow with a gentler hand than her mother. But after enjoying decades of peace once magic was driven out of their lands, some of her subjects are angry Lia Mara has an enchanted prince and a magical scraver by her side. As Grey''s deadline draws nearer, Lia Mara questions if she can be the queen her country needs.

As the two kingdoms come closer to conflict, loyalties are tested, love is threatened, and a dangerous enemy returns, in this stunning conclusion to bestselling author Brigid Kemmerer’s Cursebreaker series.', 'a-vow-so-bold-and-deadly.jpg', 3.79)
INSERT INTO products VALUES ('58348225', 'Where''s My Joey?', 'Wendy Monica Winter', 'picture-books', 0.00, 0, 'WENDY MONICA WINTER, M.Ed., is an award-winning author who lives with her husband, Calvin, in Squamish, British Columbia, Canada. Wendy enjoys bouncing around like Mamma Kangaroo. You can spot her big grin as she plays with kids at the park. She also likes to visit the local mountains to bounce on her mountain bike and even her skis! She loves exploring new cultures and countries on our beautiful planet. In fact, travel inspired her to write her first book. While teaching in Perth, Australia, Wendy came up with this story . This award-winning book and its coloring book is the first in a series. Her second book, entitiled is filled with not-so-scary scary monsters.

For more information, please visit:', 'January 11, 2021', 'Mother Kangaroo cannot find her Joey! Will she find her baby kangaroo before dinner gets cold? Who will help Mother Kangaroo in Australia? Does Koala, Emu or Kookaburra know where Joey is?

Who will help Mother Kangaroo in Canada? Do Moose or Bear or Beaver have any clues? Read and find out!

Written by a Canadian teacher who taught in Australia, this book is entertaining, engaging, and educational on many levels. (It even has a secret spiritual message for those who want to discover it.) Filled with gorgeous illustrations and a beautiful story, this is a book all ages will enjoy as well.

PINNACLE BOOK ACHIEVEMENT AWARD GOLD WINNER
BOOK EXCELLENCE AWARD GOLD WINNER
WISHING SHELF BOOK AWARD BRONZE WINNER
LITERARY TITAN AWARD GOLD WINNER', 'where-s-my-joey.jpg', 4.27)

INSERT INTO products VALUES ('26883206', 'Redemption Road', 'John Hart', 'mystery', 12.99, 16, 'JOHN HART is the author of six New York Times bestsellers, and of THE UNWILLING, which will be released on February 2, 2021. The only author in history to win the best novel Edgar Award for consecutive novels, Hart has also won the Barry Award, the Southern Independent Bookseller’s Award for Fiction, the Ian Fleming Steel Dagger Award and the North Carolina Award for Literature. His novels have been translated into thirty language and can be found in over seventy countries. “My only real dream,” John declares, “has been to write well and to be published well.”

He lives in Virginia with his wife, two daughters, and four dogs.', 'May 3, 2016', 'Now at NYT Besteller
Over 2 million copies of his books in print. The first and only author to win back-to-back Edgars for Best Novel. Every book a New York Times bestseller. After five years, John Hart is back.
Since his debut bestseller, The King of Lies, reviewers across the country have heaped praise on John Hart, comparing his writing to that of Pat Conroy, Cormac McCarthy and Scott Turow. Each novel has taken Hart higher on the New York Times Bestseller list as his masterful writing and assured evocation of place have won readers around the world and earned history''s only consecutive Edgar Awards for Best Novel with Down River and The Last Child. Now, Hart delivers his most powerful story yet.
Imagine:', 'redemption-road.jpg', 4.09)
INSERT INTO products VALUES ('25663717', 'The Two-Family House', 'Lynda Cohen Loigman', 'historical-fiction', 11.99, 44, 'Lynda Cohen Loigman grew up in Longmeadow, MA. She received a B.A. in English and American Literature from Harvard College and a J.D. from Columbia Law School. Her debut novel, The Two-Family House, was a USA Today bestseller and a nominee for the Goodreads 2016 Choice Awards in Historical Fiction. Her second novel, The Wartime Sisters, was selected as a Woman''s World Book Club pick and a Best Book of 2019 by Real Simple Magazine. The Matchmaker’s Gift, her third novel, will be published by St. Martin’s Press in September of 2022.', 'March 8, 2016', 'Brooklyn, 1947: in the midst of a blizzard, in a two-family brownstone, two babies are born minutes apart to two women. They are sisters by marriage with an impenetrable bond forged before and during that dramatic night; but as the years progress, small cracks start to appear and their once deep friendship begins to unravel. No one knows why, and no one can stop it. One misguided choice; one moment of tragedy. Heartbreak wars with happiness and almost but not quite wins.

From debut novelist Lynda Cohen Loigman comes The Two-Family House, a moving family saga filled with heart, emotion, longing, love, and mystery.


"Two families, both living in one house, drive an exquisitely written novel of love, alliances, the messiness of life and long buried secrets. Loigman''s debut is just shatteringly wonderful and I can''t wait to see what she does next." - Caroline Leavitt, bestselling author of and

"No good deed goes unpunished. In a single, intensely charged moment, two women come to a private agreement meant to assure each other''s happiness. But as Lynda Cohen Loigman deftly reveals, life is not so simple, especially when it involves two families, tightly intertwined. is sympathetically observed and surely plotted all the way through to its deeply satisfying conclusion." - Christina Schwarz, author of (an Oprah''s Book Club pick) and national bestseller', 'the-two-family-house.jpg', 3.93)
INSERT INTO products VALUES ('23909755', 'City of Blades', 'Robert Jackson Bennett', 'fantasy', 9.99, 44, 'Robert Jackson Bennett is a two-time award winner of the Shirley Jackson Award for Best Novel, an Edgar Award winner for Best Paperback Original, and is also the 2010 recipient of the Sydney J Bounds Award for Best Newcomer, and a Philip K Dick Award Citation of Excellence. City of Stairs was shortlisted for the Locus Award and the World Fantasy Award. City of Blades was a finalist for the 2015 World Fantasy, Locus, and British Fantasy Awards. His eighth novel, FOUNDRYSIDE, will be available in the US on 8/21 of 2018 and the UK on 8/23.', 'January 7, 2016', 'A generation ago, the city of Voortyashtan was the stronghold of the god of war and death, the birthplace of fearsome supernatural sentinels who killed and subjugated millions.

Now, the city’s god is dead. The city itself lies in ruins. And to its new military occupiers, the once-powerful capital is a wasteland of sectarian violence and bloody uprisings.

So it makes perfect sense that General Turyin Mulaghesh — foul-mouthed hero of the battle of Bulikov, rumored war criminal, ally of an embattled Prime Minister — has been exiled there to count down the days until she can draw her pension and be forgotten.

At least, it makes the perfect story.

The truth is that the general has been pressed into service one last time, dispatched to investigate a discovery. For while the city’s god is most certainly dead, is awakening in Voortyashtan. And someone is determined to make the world tremble at the the city’s awful power again.', 'city-of-blades.jpg', 4.21)
-- INSERT INTO products VALUES ('31154244', 'Preppy: The Life and Death of Samuel Clearwater, Part One', 'T.M. Frazier', 'Dark', 0.00, 0, 'T.M. (Tracey Marie) Frazier never dreamed that a single person would ever read a word she wrote when she published her first book. Now, she is a eight-time USA Today bestselling author and her books have been translated into numerous languages and published all around the world.

-- T.M. enjoys writing what she calls ‘wrong side of the tracks romance’ with morally corrupt anti-heroes and ballsy heroines.

-- Her books have been described as raw, dark and gritty. Basically, what that means, is while some authors are great at describing a flower as it blooms, T.M. is better at describing it in the final stages of decay.

-- She loves meeting her readers, but if you see her at an event please don’t pinch her because she''s not ready to wake up from this amazing dream.

-- Join T.M. in Frazierland!', 'October 25, 2016', 'You thought Preppy was dead...you thought wrong.

-- Samuel Clearwater, A.K.A Preppy, likes bowties, pancakes, suspenders, good friends, good times, good drugs, and a good f*ck.
-- He s worked his way out from beneath a hellish childhood and is living the life he s always imagined for himself. When he meets a girl, a junkie on the verge of ending it all, he s torn between his feelings for her and the crippling fear that she could be the one to end the life he loves.
-- Andrea Dre Capulet is strung out and tired.
-- Tired of living for her next fix. Tired of doing things that make her stomach turn. Tired of looking in the mirror at the reflection of the person she s become. Just when she decides to end it all, she meets a man who will change the course of both their lives forever.
-- And their deaths.
-- For most people, death is the end of their story.
-- For Preppy and Dre, death was only the beginning."', 'preppy.jpg', 4.57)
INSERT INTO products VALUES ('30806103', 'Kill Process', 'William Hertling', 'science-fiction', 4.99, 21, '', 'June 18, 2016', 'By day, Angie, a twenty-year veteran of the tech industry, is a data analyst at Tomo, the world''s largest social networking company; by night, she exploits her database access to profile domestic abusers and kill the worst of them. She can''t change her own traumatic past, but she can save other women.

When Tomo introduces a deceptive new product that preys on users'' fears to drive up its own revenue, Angie sees Tomo for what it really is--another evil abuser. Using her coding and hacking expertise, she decides to destroy Tomo by building a new social network that is completely distributed, compartmentalized, and unstoppable. If she succeeds, it will be the end of all centralized power in the Internet.

But how can an anti-social, one-armed programmer with too many dark secrets succeed when the world''s largest tech company is out to crush her and a no-name government black ops agency sets a psychopath to look into her growing digital footprint?"', 'kill-process.jpg', 4.08)
INSERT INTO products VALUES ('27064358', 'Disappearance at Devil''s Rock', 'Paul Tremblay', 'horror', 9.99, 73, 'Paul Tremblay has won the Bram Stoker, British Fantasy, and Massachusetts Book awards and is the author of The Pallbearers Club (coming 2022), Survivor Song, Growing Things, The Cabin at the End of the World, Disappearance at Devil’s Rock, A Head Full of Ghosts, and the crime novels The Little Sleep and No Sleep Till Wonderland. His essays and short fiction have appeared in the New York Times, Los Angeles Times, Entertainment Weekly online, and numerous year’s-best anthologies. He has a master’s degree in mathematics and lives outside Boston with his family. He is represented by Stephen Barbara, InkWell Management.', 'June 21, 2016', 'A family is shaken to its core after the mysterious disappearance of a teenage boy in this eerie tale, a blend of literary fiction, psychological suspense, and supernatural horror from the author of A Head Full of Ghosts.

Late one summer night, Elizabeth Sanderson receives the devastating news that every mother fears: her fourteen-year-old son, Tommy, has vanished without a trace in the woods of a local park.

The search isn’t yielding any answers, and Elizabeth and her young daughter, Kate, struggle to comprehend his disappearance. Feeling helpless and alone, their sorrow is compounded by anger and frustration. The local and state police haven’t uncovered any leads. Josh and Luis, the friends who were with Tommy last, may not be telling the whole truth about that night in Borderland State Park, when they were supposedly hanging out at a landmark the local teens have renamed Devil’s Rock— rumored to be cursed.

Living in an all-too-real nightmare, riddled with worry, pain, and guilt, Elizabeth is wholly unprepared for the strange series of events that follow. She believes a ghostly shadow of Tommy materializes in her bedroom, while Kate and other local residents claim to see a shadow peering through their own windows in the dead of night. Then, random pages torn from Tommy’s journal begin to mysteriously appear—entries that reveal an introverted teenager obsessed with the phantasmagoric; the loss of his father, killed in a drunk-driving accident a decade earlier; a folktale involving the devil and the woods of Borderland; and a horrific incident that Tommy believed connected them all and changes everything.

As the search grows more desperate, and the implications of what happened becomes more haunting and sinister, no one is prepared for the shocking truth about that night and Tommy’s disappearance at Devil’s Rock.', 'disappearance-at-devil-s-rock.jpg', 3.60)
INSERT INTO products VALUES ('31188362', 'Alan Partridge: Nomad', 'Alan Partridge', 'fiction', 4.99, 80, 'Journalist, presenter, broadcaster, husband, father, vigorous all-rounder – Alan Partridge – a man with a fascinating past and an amazing future. Gregarious and popular, yet Alan’s never happier than when relaxing in his own five-bedroom, south-built house with three acres of land and access to a private stream. But who is this mysterious enigma?

Alan Gordon Partridge is the best – and best-loved – radio presenter in the region. Born into a changing world of rationing, Teddy Boys, apes in space and the launch of ITV, Alan’s broadcasting career began as chief DJ of Radio Smile at St. Luke’s Hospital in Norwich. After replacing Peter Flint as the presenter of Scout About, he entered the top 8 of BBC sports presenters.

But Alan’s big break came with his primetime BBC chat show Knowing Me, Knowing You. Sadly, the show battled against poor scheduling, having been put up against News at Ten, then in its heyday. Due to declining ratings, a single catastrophic hitch (the killing of a guest on air) and the dumbing down of network TV, Alan’s show was cancelled. Not to be dissuaded, he embraced this opportunity to wind up his production company, leave London and fulfil a lifelong ambition to return to his roots in local radio.

------

Alan Gordon Partridge is a fictional radio and television presenter portrayed by English comedian Steve Coogan and invented by Coogan, Armando Iannucci, Stewart Lee and Richard Herring for the BBC Radio 4 programme ''On The Hour.'' A parody of both sports commentators and chat show presenters, among others, the character has appeared in two radio series, three television series and numerous TV and radio specials, including appearances on BBC''s Comic Relief, which have followed the rise and fall of his career. He returned to television in ''Alan Partridge - Welcome to the Places of My Life,'' which aired on Sky Atlantic in June 2012.', 'October 20, 2016', 'In Alan Partridge: Nomad, Alan dons his boots, windcheater and scarf and embarks on an odyssey through a place he once knew - it''s called Britain - intent on completing a journey of immense personal significance. Diarising his ramble in the form of a ''journey journal'', Alan details the people and places he encounters, ruminates on matters large and small and, on a final leg fraught with danger, becomes - not a man (because he was one to start off with) - but a better, more inspiring example of a man. This deeply personal book is divided into chapters and has a colour photograph on the front cover. It is deeply personal. Through witty vignettes, heavy essays and nod-inducing pieces of wisdom, Alan shines a light on the nooks of the nation and the crannies of himself, making this a biography that biographs the biographer while also biographing bits of Britain.', 'alan-partridge.jpg', 4.15)
-- INSERT INTO products VALUES ('25779641', 'Don''t Be a Jerk: And Other Practical Advice from Dogen, Japan''s Greatest Zen Master', 'Brad Warner', 'Buddhism', 9.99, 17, 'Brad Warner is an ordained Zen Master (though he hates that term) in the Soto lineage founded in Japan by Master Dogen Zenji in the 13th century. He''s the bass player for the hardcore punk rock group 0DFx (aka Zero Defex) and the ex-vice president of the Los Angeles office of the company founded by the man who created Godzilla.

-- Brad was born in Hamilton, Ohio in 1964. In 1972, his family relocated to Nairobi, Kenya. When Brad returned to Wadsworth three years later, nothing about rural Ohio seemed quite the same anymore.

-- In 1982 Brad joined 0DFx. 0DFx caught the attention of a number of major bands on the hardcore punk scene. But they soon broke up leaving a single eighteen second burst of noise, titled Drop the A-Bomb On Me, as their only recorded legacy on a compilation album called P.E.A.C.E./War.

-- In 1993, Brad went to Japan to realize a childhood dream to actually work for the people who made low budget Japanese monster movies. To his own astonishment, he landed himself a job with one of Japan''s leading producers of man-in-a-rubber-dinosaur-costume giant monster movies.

-- Back in the early 80s, while still playing hardcore punk, Brad became involved in Zen Buddhism. The realistic, no bullshit philosophy reminded him of the attitude the punks took towards music. Once he got to Japan, he began studying the philosophy with an iconoclastic rebel Zen Master named Gudo Nishijima. After a few years, Nishijima decided to make Brad his successor as a teacher of Zen.

-- In 2003 he published his first book, "Hardcore Zen: Punk Rock, Monster Movies and the Truth About Reality." In 2007 he followed that up with "Sit Down and Shut Up," a punk-informed look at 13th century Zen Master Dogen. His third book is "Zen Wrapped in Karma Dipped in Chocolate."', 'March 15, 2016', 'A Radical but Reverent Paraphrasing of Dogen’s Treasury of the True Dharma Eye

-- “Even if the whole universe is nothing but a bunch of jerks doing all kinds of jerk-type things, there is still liberation in simply not being a jerk.” — Eihei Dogen (1200–1253 CE)

-- The Shobogenzo (The Treasury of the True Dharma Eye) is a revered eight-hundred-year-old Zen Buddhism classic written by the Japanese monk Eihei Dogen. Despite the timeless wisdom of his teachings, many consider the book difficult to understand and daunting to read. In Don’t Be a Jerk, Zen priest and bestselling author Brad Warner, through accessible paraphrasing and incisive commentary, applies Dogen’s teachings to modern times. While entertaining and sometimes irreverent, Warner is also an astute scholar who sees in Dogen very modern psychological concepts, as well as insights on such topics as feminism and reincarnation. Warner even shows that Dogen offered a “Middle Way” in the currently raging debate between science and religion. For curious readers worried that Dogen’s teachings are too philosophically opaque, is hilarious, understandable, and wise.', 'don-t-be-a-jerk.jpg', 3.94)
INSERT INTO products VALUES ('30634883', 'A Smile in One Eye: a Tear in the Other', 'Ralph Webster', 'nonfiction', 0.00, 0, 'Award winning author Ralph Webster received worldwide acclaim when his first book, A Smile in One Eye: A Tear in the Other, was voted by readers as a Goodreads 2016 Choice Awards Nominee for Best Memoir/Autobiography. His books, A Smile in One Eye, One More Moon, The Other Mrs. Samson, and now his fourth, The Piano Bench are proven book club selections for thought-provoking and engaging discussions. Whether in person or online, Ralph welcomes and values his exchanges with readers and makes every effort to participate in conversations about his books. Now retired, he lives with his wife, Ginger, on the Outer Banks of North Carolina.

Please to schedule via Zoom, Skype or in person for your book club.', 'June 28, 2016', 'Librarian''s Note: This is an alternate-cover edition for ASIN B01HRZ13O2

The Third Reich is rising. The creeping madness in the heart of Germany will soon stain the entire world. This is the chilling account of one family as they flee for their lives.

The Wobsers are prosperous, churchgoing, patriotic Germans living in a small East Prussian town. When Hitler seizes power, their comfortable family life is destroyed by a horrifying Nazi regime. Baptized and confirmed as Lutherans, they are told they are Jewish, a past always respected but rarely considered. This distinction makes a life-and-death difference. Suddenly, it is no longer a matter of faith or religion; their lives are defined by race. It is a matter of bloodlines. And, in Nazi Germany, they have the wrong blood.

Written by a second generation Holocaust survivor, this is a compelling refugee story laced with contemporary overtones.

In addition to serving as a fascinating piece of history, is a passionate call to arms for organizations and individuals to properly protect and help the world’s refugees.', 'a-smile-in-one-eye.jpg', 4.24)
INSERT INTO products VALUES ('28789644', 'Blood at the Root: A Racial Cleansing in America', 'Patrick Phillips', 'History', 8.41, 40, 'Patrick Philips was born in Atlanta, Georgia. He earned a BA from Tufts University, an MFA from the University of Maryland, and a PhD in English Renaissance literature from New York University. He is the author of the poetry collections Chattahoochee (2004), winner of the Kate Tufts Discovery Award, Boy (2008), and Elegy for a Broken Machine (2015), a finalist for the National Book Award. Through his poems, Philips frequently tells stories of earlier generations of his white, working-class family’s life in Birmingham, Alabama; in his work, he also grapples with race relations, the complex and violent dynamics of family relationships, and parenthood. In an interview for storySouth, Philips noted that he has found working in traditional poetic forms to be “generative” while acknowledging a poem’s need for both narrative and song.

His honors include a fellowship from the National Endowment for the Arts, a Guggenheim Fellowship, and a Fulbright Scholarship to the University of Copenhagen. He won the American-Scandinavian Foundation’s translation prize for his translations of the work of Danish poet Henrik Nordbrandt.', 'September 20, 2016', 'A gripping tale of racial cleansing in Forsyth County, Georgia, and a harrowing testament to the deep roots of racial violence in America.

Forsyth County, Georgia, at the turn of the twentieth century was home to a large African American community that included ministers and teachers, farmers and field hands, tradesmen, servants, and children. Many black residents were poor sharecroppers, but others owned their own farms and the land on which they’d founded the county’s thriving black churches.

But then in September of 1912, three young black laborers were accused of raping and murdering a white girl. One man was dragged from a jail cell and lynched on the town square, two teenagers were hung after a one-day trial, and soon bands of white “night riders” launched a coordinated campaign of arson and terror, driving all 1,098 black citizens out of the county. In the wake of the expulsions, whites harvested the crops and took over the livestock of their former neighbors, and quietly laid claim to “abandoned” land. The charred ruins of homes and churches disappeared into the weeds, until the people and places of black Forsyth were forgotten.

National Book Award finalist Patrick Phillips tells Forsyth’s tragic story in vivid detail and traces its long history of racial violence all the way back to antebellum Georgia. Recalling his own childhood in the 1970s and ’80s, Phillips sheds light on the communal crimes of his hometown and the violent means by which locals kept Forsyth “all white” well into the 1990s.

is a sweeping American tale that spans the Cherokee removals of the 1830s, the hope and promise of Reconstruction, and the crushing injustice of Forsyth’s racial cleansing. With bold storytelling and lyrical prose, Phillips breaks a century-long silence and uncovers a history of racial terrorism that continues to shape America in the twenty-first century.', 'blood-at-the-root.jpg', 4.31)
INSERT INTO products VALUES ('22580997', 'Citizen Scientist: Searching for Heroes and Hope in an Age of Extinction', 'Mary Ellen Hannibal', 'Science', 2.99, 43, '', 'August 1, 2016', 'Citizen science might just be our last, best chance to fight extinction. But is there really hope for threatened species? Mary Ellen Hannibal needed to find out.

Hannibal, an award-winning writer and emerging emissary from scientists to the public, sets out to become a citizen scientist herself. In search of vanishing species, she wades into tide pools, follows hawks, and scours mountains. The data she collects will help environmental research—but her most precious discovery might be her fellow citizen scientists: a heroic cast of volunteers devoting long hours to helping scientists measure—and even slow—today’s unprecedented mass extinction.

A consummate reporter, Hannibal digs into the origins of the tech-savvy citizen science movement—tracing it back through centuries of amateur observation by writers and naturalists. Prompted by her novelist father’s sudden death, she also examines her own past and discovers a family legacy of looking closely at the world. Her personal loss only fuels her quest to bear witness to life, and so she ultimately returns her gaze to the wealth of species still left to fight for.

Combining research and memoir in impassioned prose, is a literary event, a blueprint for action, and the story of how one woman rescues herself from an odyssey of loss—with a new kind of science.', 'citizen-scientist.jpg', 3.66)
INSERT INTO products VALUES ('28962990', 'Deep Run Roots: Stories and Recipes from My Corner of the South', 'Vivian Howard', 'Cookbooks', 16.99, 17, '', 'October 4, 2016', 'Vivian Howard, star of PBS''s A CHEF''S LIFE, celebrates the flavors of North Carolina''s coastal plain in more than 200 recipes and stories.

This new classic of American country cooking proves that the food of Deep Run, North Carolina--Vivian''s home--is as rich as any culinary tradition in the world.


Organized by ingredient with dishes suited to every skill level--from beginners to confident cooks--DEEP RUN ROOTS features time-honored simple preparations, extraordinary meals from her acclaimed restaurant Chef and the Farmer, and recipes that bring new traditions to life. Home cooks will find photographs for every single recipe.


As much a storybook as it is a cookbook, DEEP RUN ROOTSimparts the true tale of Southern food: rooted in family and tradition, yet calling out to the rest of the world.


Ten years ago, Vivian opened Chef and the Farmer and put the nearby town of Kinston on the culinary map. But in a town paralyzed by recession, she couldn''t hop on every new culinary trend. Instead, she focused on rural development: If you grew it, she''d buy it. Inundated by local sweet potatoes, blueberries, shrimp, pork, and beans, Vivian learned to cook the way generations of Southerners before her had, relying on resourcefulness, creativity, and the old ways of preserving food.


DEEP RUN ROOTS is the result of those years of effort to discover the riches of Eastern North Carolina. Like , , and before it, this is landmark work of American food writing.



Recipes include:
Family favorites like Blueberry BBQ Chicken, Creamed Collard-Stuffed Potatoes, Fried Yams with Five-Spice Maple Bacon Candy, Chicken and Rice, and Country-Style Pork Ribs in Red Curry-Braised Watermelon,
Crowd-pleasers like Butterbean Hummus, Tempura-Fried Okra with Ranch Ice Cream, Pimiento Cheese Grits with Salsa and Pork Rinds, Cool Cucumber Crab Dip, and Oyster Pie,
Show-stopping desserts like Warm Banana Pudding, Peaches and Cream Cake, Spreadable Cheesecake, and Pecan-Chewy Pie,
And 200 more quick breakfasts, weeknight dinners, holiday centerpieces, seasonal preserves, and traditional preparations for all kinds of cooks.
---
Interior photographs by Rex Miller. Jacket photograph by Stacey Van Berkel Photography. Illustrations by Tatsuro Kiuchi.', 'deep-run-roots.jpg', 4.49)
INSERT INTO products VALUES ('29436571', 'March: Book Three', 'John Lewis', 'graphic-novels', 10.44, 10, 'John Robert Lewis was the U.S. Representative for Georgia''s 5th congressional district, serving since 1987 and was the dean of the Georgia congressional delegation. He was a leader in the American Civil Rights Movement and chairman of the Student Nonviolent Coordinating Committee (SNCC), playing a key role in the struggle to end segregation. He was a member of the Democratic Party and was one of the most liberal legislators.

Barack Obama honoured Lewis with the Presidential Medal of Freedom, and they marched hand in hand in Selma on the 50th anniversary of the Bloody Sunday attack (March 7, 1965).', 'August 2, 2016', 'Welcome to the stunning conclusion of the award-winning and best-selling MARCH trilogy. Congressman John Lewis, an American icon and one of the key figures of the civil rights movement, joins co-writer Andrew Aydin and artist Nate Powell to bring the lessons of history to vivid life for a new generation, urgently relevant for today''s world.', 'march.jpg', 4.65)
INSERT INTO products VALUES ('25664566', 'The Darkening Trapeze: Last Poems', 'Larry Levis', 'Poetry', 9.99, 33, 'Larry Patrick Levis was born in Fresno, California, on September 30, 1946. His father was a grape grower, and in his youth Levis drove a tractor, pruned vines, and picked grapes in Selma, California. He earned a bachelor''s degree from Fresno State College (now California State University, Fresno) in 1968, a master''s degree from Syracuse University in 1970, and a Ph.D. from the University of Iowa in 1974.

Among his honors were a YM-YWHA Discovery Award, three fellowships in poetry from the National Endowment for the Arts, a Fulbright Fellowship, and a Guggenheim Fellowship.

Levis died of a heart attack in 1996, at the age of 49.', 'January 5, 2016', 'The empty bar that someone was supposed to swing to him
Did not arrive, & so his outstretched flesh itself became

A darkening trapeze. The two other acrobats were thieves.
--from "Elegy with a Darkening Trapeze Inside It"

The Darkening Trapeze collects the last poems by Larry Levis, written during the extraordinary blaze of his final years when his poetry expanded into the ambitious operatic masterpieces he is known for. Edited and with an afterword by David St. John and published twenty years after Levis''s death, this collection contains major unpublished works, including final elegies, brief lyrics, and a coda believed to be the last poem Levis wrote, a heart-wrenching poem about his son. The Darkening Trapeze is an astonishing collection by a poet many consider to be among the greatest of late-twentieth-century American poetry.', 'the-darkening-trapeze.jpg', 4.23)
INSERT INTO products VALUES ('29448966', 'Beat the Rain: A dark, twisting ''fall out of love'' story with an epic end you won’t see coming', 'Nigel Jay Cooper', 'fiction', 0.00, 0, 'Author, father, cat and dog owner. More than a list of things. Probably.

Nigel lived comes from South London, lived in Brighton UK for 20 years and now lives in the French Alps with his family.

Nigel''s Invisible Lives series of novels are available now:

Beat The Rain, was a semi-finalist for Best Debut Author in the Goodreads Choice Awards.

The Pursuit of Ordinary was a finalist for The People''s Book Prize for Fiction, was longlisted for The Guardian''s Not The Booker Prize and was a call in nomination for the Booker Prize.

Nigel''s third ''Invisible Lives'' novel, Life, Slightly, has recently been released.

Nigel is currently working on a new mystery/detective novel series, as well as his first non-fiction title.', 'July 29, 2016', 'Alternate cover editions can be found here and here.

All relationships start out as love stories. They don''t all end as one.

After Louise''s lover passes away, will a fragile new relationship with his twin brother bring comfort -- or destroy them both? A haunting exploration of love and loss.

Goodreads Choice Awards nominee, Best Debut Author and Roundfire''s Bestselling Fiction title, is a modern love story - or falling out of love story - providing a moving and vulnerable depiction of a relationship in decline.

At times humorous, at times heartbreaking, it explores what it means to live, to love and to lose.

The first novel in the #OrdinaryLives series.', 'beat-the-rain.jpg', 3.95)
INSERT INTO products VALUES ('25022128', 'Inferno', 'Catherine Doyle', 'young-adult', 8.99, 0, 'Catherine Doyle grew up in the West of Ireland. She holds a first-class BA in Psychology and a first-class MA in Publishing. She is the author of the Young Adult Blood for Blood trilogy (Vendetta, Inferno and Mafiosa), which is often described as Romeo and Juliet meets the Godfather. It was inspired by her love of modern cinema. Her debut Middle Grade novel, The Storm Keeper''s Island (Bloomsbury, 2018), is an adventure story about family, bravery and self-discovery. It is set on the magical island of Arranmore, where her grandparents grew up, and is inspired by her ancestors'' real life daring sea rescues.

Aside from more conventional interests in movies, running and travelling, Catherine also enjoys writing about herself in the third-person.', 'January 7, 2016', 'Romeo and Juliet meets The Godfather in the second installment of Catherine Doyle''s Blood for Blood series.

Sophie''s life has been turned upside-down, and she''s determined to set things right. But Nic, the Falcone brother who represents everything she''s trying to forget, won''t give up on their love - and it''s Luca''s knife she clutches for comfort. Soon another mafia clan spoils the fragile peace - and with her heart drawn in one direction and her blood in another, Sophie''s in deeper than ever.', 'inferno.jpg', 4.44)
INSERT INTO products VALUES ('27064385', 'Ivory and Bone', 'Julie Eshbaugh', 'young-adult', 4.99, 94, 'Julie Eshbaugh is a YA writer and former filmmaker. She made two short films and then spent several years producing an online video series for teens which received several honors from the Webby Awards. Her YA fantasy standalone, CROWN OF OBLIVION, was released by Quill Tree Books in November 2019. She is also the author of IVORY AND BONE (HarperTeen 2016) and OBSIDIAN AND STARS (HarperTeen 2017). You can learn more about Julie’s writing escapades by visiting .', 'June 7, 2016', 'Two clans. Only one will survive.

The only life seventeen-year-old Kol knows is hunting at the foot of the Great Ice with his brothers. But food is becoming scarce, and without another clan to align with, Kol, his family, and their entire group are facing an uncertain future.

Traveling from the south, Mya and her family arrive at Kol’s camp with a trail of hurt and loss behind them, and hope for a new beginning. When Kol meets Mya, her strength, independence, and beauty instantly captivate him, igniting a desire for much more than survival.

Then on a hunt, Kol makes a grave mistake that jeopardizes the relationship that he and Mya have only just started to build. Mya was guarded to begin with—and for good reason—but no apology or gesture is enough for her to forgive him. Soon after, another clan arrives on their shores. And when Mya spots Lo, a daughter of this new clan, her anger intensifies, adding to the already simmering tension between families. After befriending Lo, Kol learns of a dark history between Lo and Mya that is rooted in the tangle of their pasts.

When violence erupts, Kol is forced to choose between fighting alongside Mya or trusting Lo’s claims. And when things quickly turn deadly, it becomes clear that this was a war that one of them had been planning all along.', 'ivory-and-bone.jpg', 3.54)
INSERT INTO products VALUES ('25897837', 'Maybe Something Beautiful: How Art Transformed a Neighborhood', 'F. Isabel Campoy', 'picture-books', 11.49, 75, 'F. ISABEL CAMPOY is the author of numerous children’s books in the areas of poetry, theatre, stories, biographies, and art. As a researcher she has published extensively bringing to the curriculum an awareness of the richness of the Hispanic culture. She is an educator specialized in the area of literacy and home school interaction, topics on which she lecturers nationally. An internationally recognized scholar devoted to the study of language acquisition, a field in which she started publishing in l973 after obtaining her degree in English Philology from Universidad Complutense in Madrid, Spain; and post graduate work in Reading University in England, and UCLA in the United States.

Her many accolades include ALA Notables, the San Francisco Library Award, the Reading the World Award from the University of San Francisco, the NABE Ramón Santiago Award, the International Latino Children’s Book Award, and nine Junior Library Guild selections. She is a member of the North American Academy of Spanish Language.', 'April 12, 2016', 'What good can a splash of color do in a community of gray? As Mira and her neighbors discover, more than you might ever imagine! Based on the true story of the Urban Art Trail in San Diego, California, Maybe Something Beautiful reveals how art can inspire transformation and how even the smallest artists can accomplish something big. Pick up a paintbrush and join the celebration!', 'maybe-something-beautiful.jpg', 4.26)
INSERT INTO products VALUES ('36373648', 'The Mars Room', 'Rachel Kushner', 'fiction', 12.99, 25, 'Rachel Kushner is the bestselling author of three novels: the Booker Prize- and NBCC Award–shortlisted The Mars Room; The Flamethrowers, a finalist for the National Book Award and a New York Times top ten book of 2013; and Telex from Cuba, a finalist for the National Book Award. She has been awarded prizes and fellowships from the American Academy of Arts and Letters and the Guggenheim Foundation. Her novels are translated into 26 languages. She lives in Los Angeles and wants you to know that if you''re reading this and curious about Rachel, whatever is unique and noteworthy in her biography that you might want to find out about is in her new book, The Hard Crowd, which will be published in April 2021. An excerpt of it appeared in the New Yorker here: .', 'May 1, 2018', 'It’s 2003 and Romy Hall is at the start of two consecutive life sentences at Stanville Women’s Correctional Facility, deep in California’s Central Valley. Outside is the world from which she has been severed: the San Francisco of her youth and her young son, Jackson. Inside is a new reality: thousands of women hustling for the bare essentials needed to survive; the bluffing and pageantry and casual acts of violence by guards and prisoners alike; and the deadpan absurdities of institutional living, which Kushner evokes with great humor and precision.', 'the-mars-room.jpg', 3.46)
INSERT INTO products VALUES ('38496758', 'Wrecked', 'Joe Ide', 'mystery', 11.99, 68, 'Joe Ide is of Japanese American descent. He grew up in South Central Los Angeles, an economically depressed area with a largely black population. Gangs and street crime were rampant. Like a lot of kids, Joe wanted to belong and his speech, style, musical tastes and attitudes reflected the neighborhood.

His favorite books were the Conan Doyle Sherlock Holmes stories. That a person could make his way in the world and vanquish his enemies with just his intelligence fascinated him.

Eventually, he went on to university and received a graduate degree in education. He worked as a school teacher, a college lecturer, a corporate middle manager and director of an NGO that offered paralegal services and emergency shelter to abused women and children. He went on to write screenplays for a number of major studios but none of the projects came to fruition.

It was then he decided to write his debut novel, IQ, about an unlicensed, underground detective; a character inspired by his early experiences and love of Sherlock Holmes.

Joe lives in Santa Monica, California, with his wife and Golden Retriever, Gusto.', 'October 9, 2018', 'Isaiah Quintabe--IQ for short--has never been more successful, or felt more alone. A series of high-profile wins in his hometown of East Long Beach have made him so notorious that he can hardly go to the corner store without being recognized. Dodson, once his sidekick, is now his full-fledged partner, hell-bent on giving IQ''s PI business some real legitimacy: a Facebook page, and IQ''s promise to stop accepting Christmas sweaters and carpet cleanings in exchange for PI services.

So when a young painter approaches IQ for help tracking down her missing mother, it''s not just the case Isaiah''s looking for, but the human connection. And when his new confidant turns out to be connected to a dangerous paramilitary operation, IQ falls victim to a threat even a genius can''t see coming.

Waiting for Isaiah around every corner is Seb, the Oxford-educated African gangster who was responsible for the death of his brother, Marcus. Only, this time, Isaiah''s not alone. Joined by a new love interest and his familiar band of accomplices, IQ is back--and the adventures are better than ever.', 'wrecked.jpg', 3.91)
INSERT INTO products VALUES ('36739329', 'The Great Believers', 'Rebecca Makkai', 'fiction', 6.99, 56, 'Rebecca Makkai is the author of 2023''s New York Times bestselling I HAVE SOME QUESTIONS FOR YOU, as well as the novels THE GREAT BELIEVERS, THE BORROWER and THE HUNDRED-YEAR HOUSE, and the collection MUSIC FOR WARTIME. THE GREAT BELIEVERS was a finalist for both the Pulitzer Prize and the National Book Award; it received the ALA Carnegie Medal and the LA Times Book Prize among other honors,

A 2022 Guggenheim Fellow, Rebecca teaches graduate fiction writing at Northwestern University, UNR Tahoe, and Middlebury College''s Bread Loaf School of English; and she is Artistic Director of StoryStudio Chicago. She lives in Chicago and Vermont. Visit her at RebeccaMakkai.com or on twitter@rebeccamakkai.', 'June 19, 2018', 'In 1985, Yale Tishman, the development director for an art gallery in Chicago, is about to pull off an amazing coup, bringing in an extraordinary collection of 1920s paintings as a gift to the gallery. Yet as his career begins to flourish, the carnage of the AIDS epidemic grows around him. One by one, his friends are dying and after his friend Nico''s funeral, the virus circles closer and closer to Yale himself. Soon the only person he has left is Fiona, Nico''s little sister.

Thirty years later, Fiona is in Paris tracking down her estranged daughter who disappeared into a cult. While staying with an old friend, a famous photographer who documented the Chicago crisis, she finds herself finally grappling with the devastating ways AIDS affected her life and her relationship with her daughter. The two intertwining stories take us through the heartbreak of the eighties and the chaos of the modern world, as both Yale and Fiona struggle to find goodness in the midst of disaster.

has become a critically acclaimed, indelible piece of literature; it was selected as one of New York Times Best 10 Books of the Year, a Washington Post Notable Book, a Buzzfeed Book of the Year, a Skimm Reads pick, and a pick for the New York Public Library’s Best Books of the year.', 'the-great-believers.jpg', 4.28)
INSERT INTO products VALUES ('35052265', 'Bloody Rose', 'Nicholas Eames', 'fantasy', 2.99, 18, '', 'August 28, 2018', 'Live fast, die young.

Tam Hashford is tired of working at her local pub, slinging drinks for world-famous mercenaries and listening to the bards sing of adventure and glory in the world beyond her sleepy hometown.

When the biggest mercenary band of all rolls into town, led by the infamous Bloody Rose, Tam jumps at the chance to sign on as their bard. It''s adventure she wants - and adventure she gets as the crew embark on a quest that will end in one of two ways: glory or death.

It''s time to take a walk on the wyld side.', 'bloody-rose.jpg', 4.19)
INSERT INTO products VALUES ('18460392', 'All the Bright Places', 'Jennifer Niven', 'young-adult', 8.99, 46, 'Jennifer Niven is the Emmy Award-winning #1 New York Times and International bestselling author of ten books, including All the Bright Places and Holding up the Universe. Her books have been translated in over 75 languages, and All the Bright Places has won literary awards around the world, including the GoodReads Choice Award for Best Young Adult Fiction of 2015. It was named a Best Book of the Year by Time Magazine, NPR, the Guardian, Publisher''s Weekly, YALSA, Barnes & Noble, BuzzFeed, the New York Public Library, and others, and was the #1 Kids'' Indie Next Book for Winter ''14-''15. The film starring Elle Fanning, Justice Smith, Luke Wilson, and Keegan-Michael Key, is now streaming on Netflix, with a script by Jennifer and Liz Hannah (The Post).

Jennifer is currently at work on her fourth and fifth novels for young adults, with number three— Breathless— coming out September 29. She also oversees Germ, a literary and lifestyle web magazine for girls and boys age high school and beyond that celebrates beginnings, futures, and all the amazing and agonizing moments in between. Her previous works include four novels for adults, as well as three nonfiction books. She divides her time between Los Angeles and coastal Georgia with her husband, kids, and literary cats.', 'January 6, 2015', 'The Fault in Our Stars meets Eleanor and Park in this exhilarating and heart-wrenching love story about a girl who learns to live from a boy who intends to die.

Soon to be a major motion picture starring Elle Fanning!
 
Theodore Finch is fascinated by death, and he constantly thinks of ways he might kill himself. But each time, something good, no matter how small, stops him.
 
lives for the future, counting the days until graduation, when she can escape her Indiana town and her aching grief in the wake of her sister’s recent death.
 
When Finch and Violet meet on the ledge of the bell tower at school, it’s unclear who saves whom. And when they pair up on a project to discover the “natural wonders” of their state, both Finch and Violet make more important discoveries: It’s only with Violet that Finch can be himself—a weird, funny, live-out-loud guy who’s not such a freak after all. And it’s only with Finch that Violet can forget to count away the days and start living them. But as Violet’s world grows, Finch’s begins to shrink.
 
This is an intense, gripping novel perfect for fans of Jay Asher, Rainbow Rowell, John Green, Gayle Forman, and Jenny Downham from a talented new voice in YA, Jennifer Niven.', 'all-the-bright-places.jpg', 4.13)
INSERT INTO products VALUES ('39655232', 'Alphas Like Us', 'Krista Ritchie', 'romance', 0.00, 0, 'NYT & USA Today Bestselling Authors Krista & Becca Ritchie are identical twins—one a science nerd, the other a comic book geek—but with their shared passion for writing, they combined their mental powers as kids and have never stopped telling stories. They love superheroes, flawed characters, and soul mate love.



But if you want to connect with Becca or me, you can reach out to us on our social medias or at our website:

| |


♥ Join Krista & Becca''s Fizzle Force .
♥ Inspiration for the Addicted series can be found on their .
♥ Find playlists for all of their books on
♥ Check out all of their extras! Including: bonus scenes, character interviews, fun posts and more on their .', 'March 13, 2018', 'His Bodyguard. His Love.

Maverick, know-it-all bodyguard Farrow Keene knows publicly dating American royalty comes with a great cost. Everyone wants a piece of their relationship. And as a protective boyfriend, he''s not here for the malicious hands that grab at their love life and seek to rip them apart.

But Farrow is confident -- he''s confident that he could''ve never prepared for the storm to come.



Maximoff Hale isn''t a big fan of change. And to regain the charity CEO position he lost, he agrees to a task that he''s always rejected. One that could uproot his unconventional world.

But Maximoff is afraid -- he''s afraid of the consequences that could destroy his boyfriend and his family.



Changes are on the horizon.
Big.
Messy.
Complicated.
Changes.
Maximoff & Farrow will fight for their forever. And with every breath, they promise that their love story won''t end here.', 'alphas-like-us.jpg', 4.20)
INSERT INTO products VALUES ('37534901', 'The Consuming Fire', 'John Scalzi', 'science-fiction', 9.99, 84, 'John Scalzi, having declared his absolute boredom with biographies, disappeared in a puff of glitter and lilac scent.

(If you want to contact John, using the mail function here is a really bad way to do it. Go to his site and use the contact information you find there.)', 'October 16, 2018', 'The Consuming Fire --the second thrilling novel in the bestselling Interdependency series, from the Hugo Award-winning and New York Times bestselling author John Scalzi

The Interdependency, humanity''s interstellar empire, is on the verge of collapse. The Flow, the extra-dimensional conduit that makes travel between the stars possible, is disappearing, leaving entire star systems stranded. When it goes, human civilization may go with it--unless desperate measures can be taken.

Emperox Grayland II, the leader of the Interdependency, is ready to take those measures to help ensure the survival of billions. But nothing is ever that easy. Arrayed before her are those who believe the collapse of the Flow is a myth--or at the very least, an opportunity that can allow them to ascend to power.

While Grayland prepares for disaster, others are preparing for a civil war, a war that will take place in the halls of power, the markets of business and the altars of worship as much as it will take place between spaceships and battlefields. The Emperox and her allies are smart and resourceful, but then so are her enemies. Nothing about this power struggle will be simple or easy... and all of humanity will be caught in its widening gyre.', 'the-consuming-fire.jpg', 4.21)
INSERT INTO products VALUES ('36694914', 'The Labyrinth Index', 'Charles Stross', 'fantasy', 12.99, 11, 'Charles David George "Charlie" Stross is a writer based in Edinburgh, Scotland. His works range from science fiction and Lovecraftian horror to fantasy.

Stross is sometimes regarded as being part of a new generation of British science fiction writers who specialise in hard science fiction and space opera. His contemporaries include Alastair Reynolds, Ken MacLeod, Liz Williams and Richard Morgan.

SF Encyclopedia:

Wikipedia:

Tor:', 'October 30, 2018', 'The Lovecraftian Singularity has descended upon the world in The Labyrinth Index, beginning an exciting new story arc in Charles Stross'' Hugo Award-winning Laundry Files series!

Since she was promoted to the head of the Lords Select Committee on Sanguinary Affairs, every workday for Mhari Murphy has been a nightmare. It doesn’t help that her boss, the new Prime Minister of Britain, is a manipulative and deceptive pain in the butt. But what else can she expect when working under the thumb of none other than the elder god N’yar Lat-Hotep a.k.a the Creeping Chaos?

Mhari''s most recent assignment takes her and a ragtag team of former Laundry agents across the pond into the depths of North America. The United States president has gone missing. Not that Americans are alarmed. For some mysterious reason, most of the country has forgotten the executive branch even exists. Perhaps it has to do with the Nazgûl currently occupying the government and attempting to summon Cthulhu.

It''s now up to Mhari and her team to race against the Nazgûl''s vampire-manned dragnet to find and, for his own protection, kidnap the president.

Who knew an egomaniacal, malevolent deity would have a soft spot for international relations?', 'the-labyrinth-index.jpg', 4.14)
INSERT INTO products VALUES ('36906099', 'Maeve in America: Essays by a Girl from Somewhere Else', 'Maeve Higgins', 'nonfiction', 12.99, 99, 'Maeve Anna Higgins is an Irish comedian from Cobh, County Cork, based in New York. She was a principal actor and writer of the RTÉ production Naked Camera, as well as for her own show Maeve Higgins'' Fancy Vittles. Her book of essays We Have A Good Time, Don''t We? was published by Hachette in 2012. She wrote for The Irish Times and produces radio documentaries.[2] She previously appeared on The Ray D''Arcy Show on Today FM.[3] Higgins appeared in her first starring film role in the 2019 Irish comedy Extra Ordinary.', 'August 7, 2018', 'Maeve Higgins was a bestselling memoirist and comedian in her native Ireland when, at the grand old age of thirty-one, she left the only home she’d ever known in search of something more. Like many women in their early thirties, she both was and was not the adult she wanted to be. At once smart, curious, and humane, Maeve in America is the story of how Maeve found herself, literally and figuratively, in New York City.

Here are stories of not being able to afford a dress for the ball, of learning to live with yourself while you’re still figuring out how to love yourself, of the true significance of realizing what sort of shelter dog you would be. Self-aware and laugh-out-loud funny, this collection is also a fearless exploration of the awkward questions in life, such as: Is clapping too loudly at a gig a good enough reason to break up with somebody? Is it ever really possible to leave home?

Together, the essays in Maeve in America create a startlingly funny and revealing portrait of a woman who aims for the stars but hits the ceiling, and the inimitable city that has helped shape who she is, even as she finds the words to make sense of it all.', 'maeve-in-america.jpg', 3.57)
INSERT INTO products VALUES ('36638638', 'The Path Between Us: An Enneagram Journey to Healthy Relationships', 'Suzanne Stabile', 'nonfiction', 13.29, 0, '', 'April 10, 2018', 'Most of us have no idea how others see or process their experiences. And that can make relationships hard, whether with intimate partners, with friends, or in our professional lives. Understanding the motivations and dynamics of these different personality types can be the key that unlocks sometimes mystifying behavior in others—and in ourselves.

This book from Suzanne Stabile on the nine Enneagram types and how they behave and experience relationships will guide readers into deeper insights about themselves, their types, and others'' personalities so that they can have healthier, more life-giving relationships. No one is better equipped than Suzanne Stabile, coauthor, with Ian Morgan Cron, of The Road Back to You, to share the Enneagram''s wisdom on how relationships work—or don’t.

• Why do Sixes seem so intimidated and put off by Eights, who only wish the Sixes would stop mulling things over and take action?
• Why do Fives seem so unavailable, even to their closest family and friends, while Twos seem to feel everybody else’s feelings but their own and end up irritating people who don’t want their help?
• How in the world can Fours be so open and loving to you one day and restrained and distant other times?

The Enneagram not only answers these questions but gives us a way out of our usual finger pointing and judging of other people—and finding them wanting, perplexing, or impossible. Suzanne''s generous, sometimes humorous, and always insightful approach reveals why all the types behave as they do. This book offers help in fostering more loving, mature, and compassionate relationships with everyone in our lives.', 'the-path-between-us.jpg', 4.13)
INSERT INTO products VALUES ('29430746', 'Heavy', 'Kiese Laymon', 'Memoir', 11.99, 87, 'Kiese Laymon is a black southern writer, born and raised in Jackson, Mississippi. Laymon attended Millsaps College and Jackson State University before graduating from Oberlin College. He earned an MFA from Indiana University and is the author of the forthcoming novel, Long Division in June 2013 and a collection of essays, How to Slowly Kill Yourself and Others in America in August 2013. Laymon is a contributing editor at gawker.com. He has written essays and stories for numerous publications including Esquire, ESPN.com, NPR, Gawker, Truthout.com, Longman’s Hip Hop Reader, Mythium and Politics and Culture. Laymon is currently an Associate Professor of English, Creative Writing and co-director of Africana Studies at Vassar College.', 'October 16, 2018', 'In this powerful and provocative memoir, genre-bending essayist and novelist Kiese Laymon explores what the weight of a lifetime of secrets, lies, and deception does to a black body, a black family, and a nation teetering on the brink of moral collapse.

Kiese Laymon is a fearless writer. In his essays, personal stories combine with piercing intellect to reflect both on the state of American society and on his experiences with abuse, which conjure conflicted feelings of shame, joy, confusion and humiliation. Laymon invites us to consider the consequences of growing up in a nation wholly obsessed with progress yet wholly disinterested in the messy work of reckoning with where we’ve been.

In , Laymon writes eloquently and honestly about growing up a hard-headed black son to a complicated and brilliant black mother in Jackson, Mississippi. From his early experiences of sexual violence, to his suspension from college, to his trek to New York as a young college professor, Laymon charts his complex relationship with his mother, grandmother, anorexia, obesity, sex, writing, and ultimately gambling. By attempting to name secrets and lies he and his mother spent a lifetime avoiding, Laymon asks himself, his mother, his nation, and us to confront the terrifying possibility that few in this nation actually know how to responsibly love, and even fewer want to live under the weight of actually becoming free.

A personal narrative that illuminates national failures, is defiant yet vulnerable, an insightful, often comical exploration of weight, identity, art, friendship, and family that begins with a confusing childhood—and continues through twenty-five years of haunting implosions and long reverberations.', 'heavy.jpg', 4.48)
INSERT INTO products VALUES ('38525349', 'The Soul of America: The Battle for Our Better Angels', 'Jon Meacham', 'History', 13.99, 72, 'Jon Meacham is the editor of Newsweek, a Pulitzer Prize winning bestselling author and a commentator on politics, history, and religious faith in America.', 'May 8, 2018', 'Pulitzer Prize-winning author Jon Meacham helps us understand the present moment in American politics and life by looking back at critical times in our history when hope overcame division and fear.

Our current climate of partisan fury is not new, and in The Soul of America Meacham shows us how what Abraham Lincoln called the "better angels of our nature" have repeatedly won the day. Painting surprising portraits of Lincoln and other presidents, including Ulysses S. Grant, Theodore Roosevelt, Woodrow Wilson, Franklin D. Roosevelt, Harry S. Truman, Dwight Eisenhower, and Lyndon B. Johnson, and illuminating the courage of such influential citizen activists as Martin Luther King Jr., early suffragettes Alice Paul and Carrie Chapman Catt, civil rights pioneers Rosa Parks and John Lewis, First Lady Eleanor Roosevelt, and Army-McCarthy hearings lawyer Joseph N. Welch, Meacham brings vividly to life turning points in American history.

He writes about the Civil War, Reconstruction, and the birth of the Lost Cause; the backlash against immigrants in the First World War and the resurgence of the Ku Klux Klan in the 1920s; the fight for women''s rights; the demagoguery of Huey Long and Father Coughlin and the isolationist work of America First in the years before World War II; the anti-Communist witch hunts led by Senator Joseph McCarthy; and Lyndon Johnson''s crusade against Jim Crow. Each of these dramatic hours in our national life have been shaped by the contest to lead the country to look forward rather than back, to assert hope over fear — a struggle that continues even now.

While the American story has not always — or even often — been heroic, we have been sustained by a belief in progress even in the gloomiest of times. In this inspiring book, Meacham reassures us, "The good news is that we have come through such darkness before" — as, time and again, Lincoln''s better angels have found a way to prevail.', 'the-soul-of-america.jpg', 4.26)
INSERT INTO products VALUES ('36373639', 'The Tangled Tree: A Radical New History of Life', 'David Quammen', 'Science', 14.99, 31, 'David Quammen (born February 1948) is an award-winning science, nature and travel writer whose work has appeared in publications such as National Geographic, Outside, Harper''s, Rolling Stone, and The New York Times Book Review; he has also written fiction. He wrote a column called "Natural Acts" for Outside magazine for fifteen years. Quammen lives in Bozeman, Montana.', 'August 14, 2018', 'Science writer David Quammen explains how recent discoveries in molecular biology can change our understanding of evolution and life’s history, with powerful implications for human health and even our own human nature.

In the mid-1970s, scientists began using DNA sequences to reexamine the history of all life. Perhaps the most startling discovery to come out of this new field—the study of life’s diversity and relatedness at the molecular level—is horizontal gene transfer (HGT), or the movement of genes across species lines. It turns out that HGT has been widespread and important. For instance, we now know that roughly eight percent of the human genome arrived not through traditional inheritance from directly ancestral forms, but sideways by viral infection—a type of HGT.

David Quammen chronicles these discoveries through the lives of the researchers who made them—such as Carl Woese, the most important little-known biologist of the twentieth century; Lynn Margulis, the notorious maverick whose wild ideas about “mosaic” creatures proved to be true; and Tsutomu Wantanabe, who discovered that the scourge of antibiotic-resistant bacteria is a direct result of horizontal gene transfer, bringing the deep study of genome histories to bear on a global crisis in public health.', 'the-tangled-tree.jpg', 3.97)
INSERT INTO products VALUES ('37826508', 'Now & Again: Go-To Recipes, Inspired Menus + Endless Ideas for Reinventing Leftovers', 'Julia Turshen', 'Cookbooks', 16.62, 52, 'Julia Turshen is the bestselling author of Now & Again, a Goodreads Choice Awards 2018 semi-finalist (vote for her here), as well as Feed the Resistance, named the Best Cookbook of 2017 by Eater, and Small Victories, named one of the Best Cookbooks of 2016 by the New York Times and NPR.

Epicurious has called her one of the 100 Greatest Home Cooks of All Time. She is the founder of ), an inclusive digital directory of women and non-binary individuals in food. Julia lives in the Hudson Valley with her wife and pets.', 'September 4, 2018', 'A Goodreads Choice Nominee for Best Cookbooks 2018!

In Now & Again, the follow-up to what Real Simple called "an inspiring addition to any kitchen bookshelf," more than 125 delicious and doable recipes and 20 creative menu ideas help cooks of any skill level to gather friends and family around the table to share a meal (or many!) together.

This cookbook comes to life with Julia Turshen''s funny and encouraging voice and is brimming with good stuff, including:

• can''t-get-enough-of-it recipes
• inspiring menus for social gatherings, holidays and more
• helpful timelines for flawlessly throwing a party
• oh-so-helpful "It''s Me Again" recipes, which show how to use leftovers in new and delicious ways
• tips on how to be smartly thrifty with food choices

will change the way we gather, eat, and think about leftovers, and, like the name suggests, you''ll find yourself reaching for its pages time and time again.', 'now-again.jpg', 3.92)
-- INSERT INTO products VALUES ('34849021', 'Black Bolt, Vol. 1: Hard Time', 'Saladin Ahmed', 'Comics', 10.99, 55, 'Saladin Ahmed was born in Detroit and raised in a working-class, Arab American enclave in Dearborn, MI.

-- His short stories have been nominated for the Nebula and Campbell awards, and have appeared in Year''s Best Fantasy and numerous other magazines, anthologies, and podcasts, as well as being translated into five foreign languages. He is represented by Jennifer Jackson of the Donald Maass Literary Agency. THRONE OF THE CRESCENT MOON is his first novel.

-- Saladin lives near Detroit with his wife and twin children.', 'December 19, 2017', 'The silent king of the Inhumans stars in his first-ever solo series! But it begins with Black Bolt...imprisoned?! Where exactly is he? Why has he been jailed? And who could be powerful enough to hold the uncanny Black Bolt? The answers to both will shock you -and Black Bolt as well! For if he is to learn the truth, he must first win a fight to the death with a fellow inmate -the Absorbing Man! Award-winning science fiction writer Saladin Ahmed (Throne of the Crescent Moon) crafts a story as trippy as it is action-packed, with truly mind-bending art from the one-and-only Christian Ward (ODY-C)!

-- BLACK BOLT 1-6', 'black-bolt-vol-1.jpg', 3.93)
INSERT INTO products VALUES ('35356376', 'Brown: Poems', 'Kevin Young', 'Poetry', 14.99, 95, 'Kevin Young is an American poet heavily influenced by the poet Langston Hughes and the art of Jean-Michel Basquiat. Young graduated from Harvard College in 1992, was a Stegner Fellow at Stanford University (1992-1994), and received his MFA from Brown University. While in Boston and Providence, he was part of the African-American poetry group, The Dark Room Collective.

Born in Lincoln, Nebraska, Young is the author of , , , , , , and editor of ; and .

His Black Cat Blues, originally published in , was included in . Young''s poetry has appeared in , , , , and other literary magazines. In 2007, he served as guest editor for an issue of . He has written on art and artists for museums in Los Angeles and Minneapolis.

His 2003 book of poems was a finalist for the National Book Award.

After stints at the University of Georgia and Indiana University, Young now teaches writing at Emory University, where he is the Atticus Haygood Professor of English and Creative Writing, as well as the curator of the Raymond Danowski Poetry Library, a large collection of first and rare editions of poetry in English.', 'April 17, 2018', 'James Brown. John Brown''s raid. Brown v. the Topeka Board of Ed. The prize-winning author of Blue Laws meditates on all things "brown" in this powerful new collection.

Divided into "Home Recordings" and "Field Recordings," Brown speaks to the way personal experience is shaped by culture, while culture is forever affected by the personal, recalling a black Kansas boyhood to comment on our times. From "History"--a song of Kansas high-school fixture Mr. W., who gave his students "the Sixties / minus Malcolm X, or Watts, / barely a march on Washington"--to "Money Road," a sobering pilgrimage to the site of Emmett Till''s lynching, the poems engage place and the past and their intertwined power. These thirty-two taut poems and poetic sequences, including an oratorio based on Mississippi "barkeep, activist, waiter" Booker Wright that was performed at Carnegie Hall and the vibrant sonnet cycle "De La Soul Is Dead," about the days when hip-hop was growing up ("we were black then, not yet / African American"), remind us that blackness and brownness tell an ongoing story. A testament to Young''s own--and our collective--experience, offers beautiful, sustained harmonies from a poet whose wisdom deepens with time.', 'brown.jpg', 4.07)
INSERT INTO products VALUES ('35297106', 'The Terminal List', 'Jack Carr', 'fiction', 26.00, 28, 'Jack Carr is a former Navy SEAL who led special operations teams as a Team Leader, Platoon Commander, Troop Commander and Task Unit Commander. Over his 20 years in Naval Special Warfare he transitioned from an enlisted SEAL sniper specializing in communications and intelligence, to a junior officer leading assault and sniper teams in Iraq and Afghanistan, to a platoon commander practicing counterinsurgency in the southern Philippines, to commanding a Special Operations Task Unit in the most Iranian influenced section of southern Iraq throughout the tumultuous drawdown of U.S. Forces. Jack retired from active duty in 2016. He lives with his wife and three children in Park City, Utah. He is the author of The Terminal List, True Believer, and Savage Son.', 'March 6, 2018', 'A Navy SEAL has nothing left to live for and everything to kill for after he discovers that the American government is behind the deaths of his team in this ripped-from-the-headlines political thriller.

On his last combat deployment, Lieutenant Commander James Reece’s entire team was killed in a catastrophic ambush that also claimed the lives of the aircrew sent in to rescue them. But when those dearest to him are murdered on the day of his homecoming, Reece discovers that this was not an act of war by a foreign enemy but a conspiracy that runs to the highest levels of government.

Now, with no family and free from the military’s command structure, Reece applies the lessons that he’s learned in over a decade of constant warfare toward avenging the deaths of his family and teammates. With breathless pacing and relentless suspense, Reece ruthlessly targets his enemies in the upper echelons of power without regard for the laws of combat or the rule of law.

An intoxicating thriller that cautions against the seduction of absolute power and those who would do anything to achieve it, is perfect for fans of Vince Flynn, Brad Thor, Stephen Hunter, and Nelson DeMille.', 'the-terminal-list.jpg', 4.28)
INSERT INTO products VALUES ('40239755', 'The Accidentals', 'Sarina Bowen', 'young-adult', 4.99, 23, 'Sarina Bowen is the twenty-four-time USA Today bestselling and Wall Street Journal bestselling author of three dozen books, including: the True North series, and Brooklyn Hockey. She''s the co-author of and thewith Elle Kennedy. She''s the author of series, and more!
Are you looking for a friends-to-lovers story or maybe even a secret baby book? You can of Sarina''s books broken out by trope and style.
Need to know ? Get all the latest news , and so you don''t miss a book or a deal.', 'July 10, 2018', 'Never ask a question unless you’re sure you want the truth. I’ve been listening to my father sing for my whole life. I carry him in my pocket on my mp3 player. It’s just that we’ve never met face to face. My mother would never tell me how I came to be, or why my rock star father and I have never met. I thought it was her only secret. I was wrong.

When she dies, he finally appears. Suddenly I have a first class ticket into my father’s exclusive world. A world I don’t want any part of – not at this cost.
Only three things keep me my a cappella singing group, a swoony blue-eyed boy named Jake, and the burning questions in my soul. There’s a secret shame that comes from being an unwanted child. It drags me down, and puts distance between me and the boy I love.
My father is the only one alive who knows my history. I need the truth, even if it scares me.', 'the-accidentals.jpg', 4.02)
INSERT INTO products VALUES ('35495083', 'Sightwitch', 'Susan Dennard', 'fantasy', 9.99, 84, 'Susan Dennard is the award-winning, New York Times bestselling author of the Witchlands series (now in development for TV from the Jim Henson Company), and the Something Strange and Deadly series, in addition to various other fiction published online.

Before becoming an author, she got to travel the world with her M.Sc. in marine biology. She also runs the popular newsletter for writers, the Misfits and Daydreamers. When not writing or teaching writing, she can be found rolling the dice as a Dungeon Master or mashing buttons on one of her way too many consoles.

You can learn more about Susan on her , , , , or .', 'February 13, 2018', 'From New York Times bestselling author Susan Dennard, Sightwitch is an illustrated novella set in the Witchlands and told through Ryber’s journal entries and sketches.

Before Safi and Iseult battled a Bloodwitch...

Before Merik returned from the dead…

Ryber Fortiza was a Sightwitch Sister at a secluded convent, waiting to be called by her goddess into the depths of the mountain. There she would receive the gift of foretelling. But when that call never comes, Ryber finds herself the only Sister without the Sight.

Years pass and Ryber’s misfit pain becomes a dull ache, until one day, Sisters who already possess the Sight are summoned into the mountain, never to return. Soon enough, Ryber is the only Sister left. Now, it is up to her to save her Sisters, though she does not have the Sight—and though she does not know what might await her inside the mountain.

On her journey underground, she encounters a young captain named Kullen Ikray, who has no memory of who he is or how he got there. Together, the two journey ever deeper in search of answers, their road filled with horrors, and what they find at the end of that road will alter the fate of the Witchlands forever.

Set a year before , is a companion novella that also serves as a set up to , as well as an expansion of the Witchlands world.', 'sightwitch.jpg', 3.99)
INSERT INTO products VALUES ('36373280', 'The Unforgettable Guinevere St. Clair', 'Amy Makechnie', 'middle-grade', 8.99, 33, 'AMY MAKECHNIE is the author of the middle grade novels, THE UNFORGETTABLE GUINEVERE ST CLAIR, TEN THOUSAND TRIES, and THE MCNIFFICENTS.

Like Guinevere St. Clair, Amy once set sail for the Mississippi on a large piece of Styrofoam (she didn''t make it.) Like Golden from TEN THOUSAND TRIES, she''s a little obsessed with soccer. And those funny children in THE MCNIFFICENTS? Well, she has a few - plus a miniature schnauzer that''s really named Lord Tennyson (just like in the book).


Amy lives with her family in in a small New Hampshire town, and when she''s not dissecting body parts with her A&P students, you might see her out running; that''s where she works out her best plot points.

Subscribe to the newsletter, where she talks about happy things like books!', 'June 12, 2018', 'A ten-year-old girl is determined to find her missing neighbor, but the answers lead her to places and people she never expected—and maybe even one she’s been running away from—in this gorgeous debut novel that’s perfect for fans of The Thing About Jellyfish .

Guinevere St. Clair is going to be a lawyer. She was the fastest girl in New York City. She knows everything there is to know about the brain. And now that she’s living in Crow, Iowa, she wants to ride into her first day of school on a cow named Willowdale Princess Deon Dawn.

But Gwyn isn’t in Crow, Iowa, just for royal cows. Her family has moved there, where her parents grew up, in the hopes of jogging her mother Vienna’s memory. Vienna has been suffering from memory loss since Gwyn was four. She can no longer remember anything past the age of thirteen, not even that she has two young daughters. Gwyn’s father is obsessed with finding out everything he can to help his wife, but Gwyn’s focused on problems that seem a little more within her reach. Like proving that the very strange Gaysie Cutter who lives next door is behind the disappearance of her only friend, Wilbur Truesdale.

Gwyn is sure she can crack the case, but when she does she finds that not all of her investigations lead her to the places she would have expected. In fact they might just lead her to learn about the mother she’s been doing her best to forget.', 'the-unforgettable-guinevere-st-clair.jpg', 4.09)
INSERT INTO products VALUES ('33590214', 'Young Jane Young', 'Gabrielle Zevin', 'fiction', 11.99, 82, 'GABRIELLE ZEVIN is a New York Times best-selling novelist whose books have been translated into forty languages.

Her tenth novel, Tomorrow, and Tomorrow, and Tomorrow was published by Knopf in July of 2022 and was an instant New York Times Best Seller, a Sunday Times Best Seller, a USA Today Best Seller, a #1 National Indie Best Seller, and a selection of the Tonight Show’s Fallon Book Club. Maureen Corrigan of NPR’s Fresh Air called it, “a big beautifully written novel…that succeeds in being both serious art and immersive entertainment.” Following a twenty-five-bidder auction, the feature film rights to Tomorrow, and Tomorrow, and Tomorrow were acquired by Temple Hill and Paramount Studios.

The Storied Life of A.J. Fikry spent many months on the New York Times Best Seller List, reached #1 on the National Indie Best Seller List, was a USA Today Best Seller, and has been a best seller all around the world. A.J. Fikry was honored with the Southern California Independent Booksellers Award for Fiction, the Japan Booksellers’ Prize, and was long listed for the International Dublin Literary Award, among other honors. To date, the book has sold over five-million copies worldwide. It is now a feature film with a screenplay by Zevin. Young Jane Young won the Southern Book Prize and was one of the Washington Post’s Fifty Notable Works of Fiction.

She is the screenwriter of Conversations with Other Women (Helena Bonham Carter) for which she received an Independent Spirit Award Nomination for Best First Screenplay. She has occasionally written criticism for the New York Times Book Review and NPR’s All Things Considered, and she began her writing career, at age fourteen, as a music critic for the Fort Lauderdale Sun-Sentinel. Zevin is a graduate of Harvard University. She lives in Los Angeles.

NOTE: Apologies, but Gabrielle doesn''t reply to messages on Goodreads.', 'August 22, 2017', 'This is the story of five women . . .

Meet Rachel Grossman.
She’ll stop at nothing to protect her daughter, Aviva, even if it ends up costing her everything.

Meet Jane Young.
She’s disrupting a quiet life with her daughter, Ruby, to seek political office for the first time.

Meet Ruby Young.
She thinks her mom has a secret. She’s right.

Meet Embeth Levin.
She’s made a career of cleaning up her congressman husband’s messes.

Meet Aviva Grossman.
The Internet won’t let her or anyone else forget her past transgressions.

This is the story of five women . . .
. . . and the sexist scandal that binds them together.

From Gabrielle Zevin, the bestselling author of The Storied Life of A. J. Fikry, comes another story with unforgettable characters that is particularly suited to the times we live in now . . .', 'young-jane-young.jpg', 3.80)
INSERT INTO products VALUES ('31125554', 'The Fourth Monkey', 'J.D. Barker', 'Thriller', 0.00, 0, 'J.D. Barker is the New York Times and international best-selling author of numerous novels, including DRACUL and THE FOURTH MONKEY. His latest, A CALLER''S GAME, released February 22. He is currently collaborating with James Patterson. His books have been translated into two dozen languages, sold in more than 150 countries, and optioned for both film and television. Barker resides in coastal New Hampshire with his wife, Dayna, and their daughter, Ember.

A note from J.D.
As a child I was always told the dark could not hurt me, that the shadows creeping in the corners of my room were nothing more than just that, shadows. The sounds nothing more than the settling of our old home, creaking as it found comfort in the earth only to move again when it became restless, if ever so slightly. I would never sleep without closing the closet door, oh no; the door had to be shut tight. The darkness lurking inside needed to be held at bay, the whispers silenced. Rest would only come after I checked under the bed at least twice and quickly wrapped myself in the safety of the sheets (which no monster could penetrate), pulling them tight over my head.

I would never go down to the basement.

Never.

I had seen enough movies to know better, I had read enough stories to know what happens to little boys who wandered off into dark, dismal places alone. And there were stories, so many stories.

Reading was my sanctuary, a place where I could disappear for hours at a time, lost in the pages of a good book. It didn’t take long before I felt the urge to create my own.

I first began to write as a child, spinning tales of ghosts and gremlins, mystical places and people. For most of us, that’s where it begins—as children we have such wonderful imaginations, some of us have simply found it hard to grow up. I’ve spent countless hours trying to explain to friends and family why I enjoy it, why I would rather lock myself in a quiet little room and put pen to paper for hours at a time than throw around a baseball or simply watch television. Don’t get me wrong, sometimes I want to do just that, sometimes I wish for it, but even then the need to write is always there in the back of my mind, the characters are impatiently tapping their feet, waiting their turn, wanting to be heard. I wake in the middle of the night and reach for the pad beside my bed, sometimes scrawling page after page of their words, their lives. Then they’re quiet, if only for a little while. To stop would mean madness, or even worse—the calm, numbing sanity I see in others as they slip through the day without purpose. They don’t know what it’s like, they don’t understand. Something as simple as a pencil can open the door to a new world, can create life or experience death. Writing can take you to places you’ve never been, introduce you to people you’ve never met, take you back to when you first saw those shadows in your room, when you first heard the sounds mumbling ever so softly from your closet, and it can show you what uttered them. It can scare the hell out of you, and that’s when you know it’s good.

jd', 'June 27, 2017', 'For over five years, the Four Monkey Killer has terrorized the residents of Chicago. When his body is found, the police quickly realize he was on his way to deliver one final message, one which proves he has taken another victim who may still be alive.

As the lead investigator on the 4MK task force, Detective Sam Porter knows even in death, the killer is far from finished. When he discovers a personal diary in the jacket pocket of the body, Porter finds himself caught up in the mind of a psychopath, unraveling a twisted history in hopes of finding one last girl, all while struggling with personal demons of his own.

With only a handful of clues, the elusive killer’s identity remains a mystery. Time is running out and the Four Monkey Killer taunts from beyond the grave in this masterfully written fast-paced thriller.', 'the-fourth-monkey.jpg', 4.26)
INSERT INTO products VALUES ('31752152', 'Lilli de Jong', 'Janet Benton', 'historical-fiction', 9.99, 16, 'Janet Benton''s debut novel LILLI DE JONG is the diary of an unwed Quaker mother in 1883 Philadelphia who decides to try to keep her baby. It was one of LIBRARY JOURNAL''s and NPR''s Best Books 2017 and a semifinalist for the Goodreads Choice Awards and has received many additional honors. It is available in paperback, hardcover, audio book, e-book, and large print editions. Janet''s work has appeared in the New York Times, the Philadelphia Inquirer, and elsewhere. She holds an M.F.A. from the Univ. of Massachusetts, Amherst and a B. A. from Oberlin College. After working at magazines, newspapers, and publishers and teaching writing at four universities, she began The Word Studio () to offer workshops and mentoring to writers. She''s also a mother, wife, singer, and person who gets teary-eyed when she sees kindness or cruelty. She loves to interact with readers by Skype, online, and in person. See', 'May 16, 2017', 'A young woman finds the most powerful love of her life when she gives birth at an institution for unwed mothers in 1883 Philadelphia. She is told she must give up her daughter to avoid a life of poverty and shame. But she chooses to keep her.

Pregnant, abandoned by her lover, and banished from her Quaker home and teaching position, Lilli de Jong enters a charity for wronged women to deliver her child. She is stunned at how much her infant needs her and at how quickly their bond overpowers her heart. Mothers in her position have no sensible alternative to giving up their children, but Lilli can''t bear such an outcome. Determined to chart a path toward an independent life, Lilli braves moral condemnation and financial ruin in a quest to keep herself and her baby alive.

Confiding their story to her diary as it unfolds, Lilli takes readers from an impoverished charity to a wealthy family''s home to the perilous streets of a burgeoning American city. is at once a historical saga, an intimate romance, and a lasting testament to the work of mothers. "So little is permissible for a woman," writes Lilli, yet on her back every human climbs to adulthood."', 'lilli-de-jong.jpg', 3.98)
INSERT INTO products VALUES ('31522139', 'City of Miracles', 'Robert Jackson Bennett', 'fantasy', 11.99, 57, 'Robert Jackson Bennett is a two-time award winner of the Shirley Jackson Award for Best Novel, an Edgar Award winner for Best Paperback Original, and is also the 2010 recipient of the Sydney J Bounds Award for Best Newcomer, and a Philip K Dick Award Citation of Excellence. City of Stairs was shortlisted for the Locus Award and the World Fantasy Award. City of Blades was a finalist for the 2015 World Fantasy, Locus, and British Fantasy Awards. His eighth novel, FOUNDRYSIDE, will be available in the US on 8/21 of 2018 and the UK on 8/23.', 'May 2, 2017', 'Revenge. It''s something Sigrud je Harkvaldsson is very, very good at. Maybe the only thing.

So when he learns that his oldest friend and ally, former Prime Minister Shara Komayd, has been assassinated, he knows exactly what to do — and that no mortal force can stop him from meting out the suffering Shara''s killers deserve.

Yet as Sigrud pursues his quarry with his customary terrifying efficiency, he begins to fear that this battle is an unwinnable one. Because discovering the truth behind Shara''s death will require him to take up arms in a secret, decades-long war, face down an angry young god, and unravel the last mysteries of Bulikov, the city of miracles itself. And — perhaps most daunting of all — finally face the truth about his own cursed existence.', 'city-of-miracles.jpg', 4.42)
INSERT INTO products VALUES ('34950852', 'Drive', 'Kate Stewart', 'romance', 0.00, 0, 'USA Today bestselling author and Texas native, Kate Stewart, lives in
North Carolina with her husband, Nick. Nestled within the Blueridge
Mountains, Kate pens messy, sexy, angst-filled contemporary romance, as
well as romantic comedy and erotic suspense. Kate’s title, Drive, was
named one of the best romances of 2017 by The New York Daily News and
Huffington Post. Drive was also a finalist in the Goodreads Choice awards
for best contemporary romance of 2017. The Ravenhood Trilogy,
consisting of Flock, Exodus, and The Finish Line, has become an
international bestseller and reader favorite. Her holiday release, The Plight
Before Christmas, ranked #6 on Amazon’s Top 100. Kate’s works have
been featured in USA TODAY, BuzzFeed, The New York Daily News,
Huffington Post and translated into a dozen languages.
Kate is a lover of all things ’80s and ’90s, especially John Hughes films and
rap. She dabbles a little in photography, can knit a simple stitch scarf for
necessity, and on occasion, does very well at whiskey.

Contact Kate- Email-authorkatestewart@gmail.com

Facebook Group: ...

Newsletter signup:
...

Website-

Facebook-...

Instagram:', 'October 14, 2017', 'Music . . . the heart’s greatest librarian.

The average song is three and a half minutes long; those three and a half minutes could lead to a slow blink, a glimpse of the past, or catapult the soul into heart-shattering nostalgia.

At the height of my career, I had the life I wanted, the life I’d always envisioned. I’d found my tempo, my rhythm. Then I received a phone call that left me off key.

You see, my favorite songs had a way of playing simultaneously. I was in love with one man’s beats and another’s lyrics. But when it came to the soundtrack of a life, how could anyone choose a favorite song? So, to erase any doubt, I ditched my first-class ticket and decided to take a drive, fixed on the rearview.

Two days.

One playlist.

And the long road home to the man who was waiting for me.', 'drive.jpg', 4.45)
INSERT INTO products VALUES ('28220647', 'Seven Surrenders', 'Ada Palmer', 'science-fiction', 12.99, 54, '', 'March 7, 2017', 'The second book of Terra Ignota, a political SF epic of extraordinary audacity. It is a world in which near-instantaneous travel from continent to continent is free to all.

In which automation now provides for everybody’s basic needs.
In which nobody living can remember an actual war.
In which it is illegal for three or more people to gather for the practice of religion—but ecumenical “sensayers” minister in private, one-on-one.
In which gendered language is archaic, and to dress as strongly male or female is, if not exactly illegal, deeply taboo.
In which nationality is a fading memory, and most people identify instead with their choice of the seven global Hives, distinguished from one another by their different approaches to the big questions of life.

And it is a world in which, unknown to most, the entire social order is teetering on the edge of collapse.

Because even in utopia, humans will conspire. And also because something new has arisen: Bridger, the child who can bring inanimate objects to conscious life.', 'seven-surrenders.jpg', 4.20)
INSERT INTO products VALUES ('32920015', 'Bone White', 'Ronald Malfi', 'horror', 0.00, 0, 'Ronald Malfi is the bestselling, award-winning author of many novels and novellas in the horror, mystery, and thriller genres. In 2011, his novel, Floating Staircase, was nominated for a Bram Stoker Award for best novel by the Horror Writers Association, and also won a gold IPPY award. Perhaps his most well-received novel, Come with Me (2021), about a man who learns a dark secret about his wife after she''s killed, has received stellar reviews, including a starred review from BookPage, and has said, "Malfi impresses in this taut, supernaturally tinged mystery... and sticks the landing with a powerful denouement. There’s plenty here to enjoy."

His most recent novels, (2021) and (2022), tackle themes of grief and loss, and of the effects of childhood trauma and alcoholism, respectively. Both books have been critically praised, with calling a "standout" book of the year. These novels were followed by (2022), a collection of four subtly-linked novellas about haunted books and the power of the written word. received a starred review from , which called the book a "wonderfully meta collection...vibrantly imagined," and that "Malfi makes reading about the perils of reading a terrifying delight."

Among his most popular works is , a coming-of-age thriller set in the ''90s, wherein five teenage boys take up the hunt for a child murderer in their hometown of Harting Farms, Maryland. In interviews, Malfi has expressed that this is his most autobiographical book to date. In 2015, this novel was awarded the Beverly Hills International Book Award for best suspense novel. It has been optioned several times for film.

(2017), about a man searching for his lost twin brother in a haunted Alaskan mining town, was touted as "an elegant, twisted, gripping slow-burn of a novel that burrows under the skin and nestles deep," by , and has also been optioned for television by Fox21/Disney and Amazon Studios.

His novels (2015) and (2016) explore broken families forced to endure horrific and extraordinary circumstances, which has become the hallmark for Malfi''s brand of intimate, lyrical horror fiction.

His earlier works, such as (2007) and (2008) explored characters with lost or confused identities, wherein Malfi experimented with the ultimate unreliable narrators. He maintained this trend in his award-winning novel, (2011), which the author has suggested contains "multiple endings for the astute reader."

His more "monstery" novels, such as (2010) and (2012) still resonate with his inimitable brand of literary cadence and focus on character and story over plot. Both books were highly regarded by fans and reviewers in the genre.

A bit of a departure, Malfi published the crime drama in 2009, based on the true exploits of his own father, a former Secret Service agent. The book was optioned several times for film.

Ronald Malfi was born in Brooklyn, New York in 1977, the eldest of four children, and eventually relocated to Maryland, where he and his wife, Debra, currently reside along the Chesapeake Bay with their two daughters.

When he''s not writing, he''s performing with the rock back VEER, who can be found at veerband.net and on Twitter at @VeerBand

Visit with Ronald Malfi on Facebook, Twitter (@RonaldMalfi), or at .', 'July 25, 2017', 'A landscape of frozen darkness punctuated by grim, gray days.
The feeling like a buzz in your teeth.
The scrape of bone on bone. . .

Paul Gallo saw the report on the news: a mass murderer leading police to his victims graves, in remote Dread''s Hand, Alaska.

It''s not even a town; more like the bad memory of a town. The same bit of wilderness where his twin brother went missing a year ago. As the bodies are exhumed, Paul travels to Alaska to get closure and put his grief to rest.

But the mystery is only beginning. What Paul finds are superstitious locals who talk of the devil stealing souls, and a line of wooden crosses to keep what''s in the woods from coming out. He finds no closure because no one can explain exactly what happened to Danny.

And the more he searches for answers, the more he finds himself becoming part of the mystery. . .', 'bone-white.jpg', 3.89)
INSERT INTO products VALUES ('33898867', 'Waiting for the Punch: Words to Live by from the WTF Podcast', 'Marc Maron', 'nonfiction', 11.99, 16, 'Marcus David Maron is an American stand-up comedian, podcaster, writer and actor.

He has been host of The Marc Maron Show and co-host of both Morning Sedition and Breakroom Live, all politically oriented shows produced by Air America Media. He hosted Comedy Central''s Short Attention Span Theater for a year, replacing Jon Stewart. Maron was a frequent guest on the Late Show with David Letterman and made more than forty appearances on Late Night with Conan O''Brien, more than any other standup performer.

In September 2009, Maron began hosting a twice-weekly podcast titled WTF with Marc Maron in which he interviews comedians and celebrities. Highlights have included Conan O''Brien, Robin Williams, and an episode with Louis C.K. that was rated the #1 podcast episode of all time by Slate magazine. In June 2015, Maron interviewed the President of the United States, Barack Obama, at his podcast studio and home, in Highland Park, Los Angeles, California.

From 2013 to 2016, he starred in his own IFC television comedy series, Maron, for which he also served as executive producer and occasional writer.', 'October 10, 2017', 'From the beloved and wildly popular podcast WTF with Marc Maron comes a book of intimate, hilarious and life changing conversations with some of the funniest, and most important people in the world like you’ve never heard them before. Waiting for the Punch features the stories and thoughts of such luminaries as Amy Schumer, Mel Brooks, Will Ferrell, Amy Poehler, Sir Ian McKellen, Lorne Michels, Judd Apatow, Lena Dunham, Jimmy Fallon, RuPaul, Louis CK, David Sedaris, Bruce Springsteen, and President Obama.

This book is not simply a collection of these interviews, but instead something more wondrous: a running narrative of the world’s most recognizable names working through the problems, doubts, joys, triumphs, and failures we all experience. With each chapter covering a different topic: parenting, childhood, relationships, sexuality, success, failures and others, Punch becomes a sort of everyman’s guide to life. Barack Obama candidly discusses the challenges of the presidency, and the bittersweet moments of seeing your children grow up. Amy Schumer recounts the pain of her parents’ divorce. Molly Shannon uproariously remembers the time she and her best friend hopped a plane from Ohio to New York City when they were twelve on a dare. Amy Poehler dishes on why just because you become a parent doesn’t mean you have to like anybody else’s kids but your own. Bruce Springsteen expounds on the dual nature of desperation to both motivate and devastate.

Full of stories that are at once laugh-out loud funny, heartbreakingly honest, joyous, tragic and powerful, is a book to be read from cover to cover, but it is also one to return to again and again.', 'waiting-for-the-punch.jpg', 4.00)
-- INSERT INTO products VALUES ('33916342', 'Daring to Hope: Finding God''s Goodness in the Broken and the Beautiful', 'Katie Davis Majors', 'Christian', 1.99, 59, 'Katie Davis Majors moved to Uganda over a decade ago with no idea that this would be the place that God chose to build her home and her family. Today, she is a wife to Benji and mom to her fourteen favorite people. Katie and her family invest their lives in empowering the people of Uganda with education, medical care, and spiritual discipleship. She is also the founder of Amazima Ministries, an organization that cares for vulnerable children and families in Uganda and the author of the New York Times bestseller Kisses from Katie.', 'October 3, 2017', 'How do you hold on to hope
-- when you don''t get the ending
-- you asked for?

-- When Katie Davis Majors moved to Uganda, accidentally founded a booming organization, and later became the mother of thirteen girls through the miracle of adoption, she determined to weave her life together with the people she desired to serve. But joy often gave way to sorrow as she invested her heart fully in walking alongside people in the grip of poverty, addiction, desperation, and disease.

-- After unexpected tragedy shook her family, for the first time Katie began to wonder, When she turned to Him with her questions, God spoke truth to her heart and drew her even deeper into relationship with Him.

-- is an invitation to cling to the God of the impossible--the God who whispers His love to us in the quiet, in the mundane, when our prayers are not answered the way we want or the miracle doesn''t come. It''s about a mother discovering the extraordinary strength it takes to be ordinary. It''s about choosing faith no matter the circumstance and about encountering God''s goodness in the least expected places.

-- Though your heartaches and dreams may take a different shape, you will find your own questions echoed in these pages. You''ll be reminded of the gifts of joy in the midst of sorrow. And you''ll hear God''s whisper:', 'daring-to-hope.jpg', 4.42)
INSERT INTO products VALUES ('31920820', 'Priestdaddy', 'Patricia Lockwood', 'Memoir', 9.99, 89, '', 'May 2, 2017', 'The childhood of poet Patricia Lockwood was unusual in many respects. There was the location: an impoverished, nuclear waste-riddled area of the American Midwest. There was her mother, a woman who speaks almost entirely in strange riddles and warnings of impending danger. Above all, there was her gun-toting, guitar-riffing, frequently semi-naked father, who underwent a religious conversion on a submarine and found a loophole which saw him approved for the Catholic priesthood by the future Pope Benedict XVI, despite already having a wife and children.

When an unexpected crisis forces Lockwood and her husband to move back into her parents'' rectory, she must learn to live again with the family''s simmering madness, and to reckon with the dark side of her religious upbringing. Pivoting from the raunchy to the sublime, from the comic to the serious, is an unforgettable story of how we balance tradition against hard-won identity—and of how, having journeyed in the underworld, we can emerge with our levity and our sense of justice intact.', 'priestdaddy.jpg', 3.86)
INSERT INTO products VALUES ('30688762', 'Last Hope Island: Britain, Occupied Europe, and the Brotherhood That Helped Turn the Tide of War', 'Lynne Olson', 'History', 14.99, 49, 'Lynne Olson is a New York Times bestselling author of nine books of history, most of which focus on World War II. Former U.S. Secretary of State Madeleine Albright has called her "our era''s foremost chronicler of World War II politics and diplomacy."
Lynne''s latest book, Empress of the Nile: The Daredevil Archaeologist Who Saved Egypt''s Ancient Temples From Destruction, will be published by Random House on Feb. 28, 2023. Three of her previous books — Madame Fourcade''s Secret War, Those Angry Days, and Citizens of London were New York Times bestsellers.
Born in Hawaii, Lynne graduated magna cum laude from the University of Arizona. Before becoming a full-time author, she worked as a journalist for ten years, first with the Associated Press as a national feature writer in New York, a foreign correspondent in AP''s Moscow bureau, and a political reporter in Washington. She left the AP to join the Washington bureau of the Baltimore Sun, where she covered national politics and eventually the White House.
Lynne lives in Washington, DC with her husband, Stanley Cloud, with whom she co-authored two books. Visit Lynne Olson at .', 'April 25, 2017', 'An engrossing account of how Britain became the base of operations for the exiled leaders of Europe in their desperate struggle to reclaim their continent from Hitler.
When the Nazi blitzkrieg rolled over continental Europe in the early days of World War II, the city of London became a refuge for the governments and armed forces of six occupied nations — Belgium, Holland, Luxembourg, Norway, Czechoslovakia, and Poland — who escaped there to continue the fight. So, too, did General Charles de Gaulle, the self- appointed representative of free France. As the only European democracy still holding out against Hitler, Britain became known to occupied countries as ‘Last Hope Island’.', 'last-hope-island.jpg', 4.31)
INSERT INTO products VALUES ('34274957', 'Life 3.0: Being Human in the Age of Artificial Intelligence', 'Max Tegmark', 'Science', 14.99, 81, '', 'August 23, 2017', 'How will Artificial Intelligence affect crime, war, justice, jobs, society and our very sense of being human? The rise of AI has the potential to transform our future more than any other technology--and there''s nobody better qualified or situated to explore that future than Max Tegmark, an MIT professor who''s helped mainstream research on how to keep AI beneficial.

How can we grow our prosperity through automation without leaving people lacking income or purpose? What career advice should we give today''s kids? How can we make future AI systems more robust, so that they do what we want without crashing, malfunctioning or getting hacked? Should we fear an arms race in lethal autonomous weapons? Will machines eventually outsmart us at all tasks, replacing humans on the job market and perhaps altogether? Will AI help life flourish like never before or give us more power than we can handle?

What sort of future do want? This book empowers you to join what may be the most important conversation of our time. It doesn''t shy away from the full range of viewpoints or from the most controversial issues--from superintelligence to meaning, consciousness and the ultimate physical limits on life in the cosmos.', 'life-3-0.jpg', 4.01)
INSERT INTO products VALUES ('33571767', 'Half Baked Harvest Cookbook: Recipes from My Barn in the Mountains', 'Tieghan Gerard', 'Cookbooks', 5.99, 80, 'Tieghan Gerard is a food photographer, stylist, recipe developer, and author of the Half Baked Harvest Cookbook and Half Baked Harvest Super Simple, a New York Times bestseller. Her blog, Half Baked Harvest, features a hearty mix of savory, sweet, healthy, and indulgent recipes. She believes every diet should include a little bit of chocolate because balance is the key to life!', 'September 12, 2017', 'Tieghan Gerard grew up in the Colorado mountains as one of seven children. When her dad took too long to get dinner on the table every night, she started doing the cooking--at age 14. Ever-determined to reign in the chaos of her big family, Tieghan found her place in the kitchen. She had a knack for creating unique dishes, which led her to launch her blog, Half Baked Harvest. Since then, millions of people have fallen in love with her fresh take on comfort food, stunning photography, and charming life in the mountains.
While it might be a trek to get to Tieghan''s barn-turned-test kitchen, her creativity shines here: dress up that cheese board with a real honey comb; decorate a standard salad with spicy, crispy sweet potato fries; serve stir fry over forbidden black rice; give French Onion Soup an Irish kick with Guinness and soda bread; bake a secret ingredient into your apple pie (hint: it''s molasses). And a striking photograph accompanies every recipe, making a feast your eyes, too.
Whether you need to get dinner on the table for your family tonight or are planning your next get-together with friends, has your new favorite recipe.', 'half-baked-harvest-cookbook.jpg', 4.33)
INSERT INTO products VALUES ('31145185', 'Spill Zone', 'Scott Westerfeld', 'graphic-novels', 11.99, 27, 'Scott Westerfeld is a New York Times bestselling author of YA. He is best known for the Uglies and Leviathan series. His current series, IMPOSTORS, returns to the world of Uglies.

The next book in that series, MIRROR''S EDGE, comes out April 6, 2021.', 'May 2, 2017', 'Three years ago an event destroyed the small city of Poughkeepsie, forever changing reality within its borders. Uncanny manifestations and lethal dangers now await anyone who enters the Spill Zone.

The Spill claimed Addison''s parents and scarred her little sister, Lexa, who hasn t spoken since. Addison provides for her sister by photographing the Zone''s twisted attractions on illicit midnight rides. Art collectors pay top dollar for these bizarre images, but getting close enough for the perfect shot can mean death or worse.

When an eccentric collector makes a million-dollar offer, Addison breaks her own hard-learned rules of survival and ventures farther than she has ever dared. Within the Spill Zone, Hell awaits and it seems to be calling Addison''s name.', 'spill-zone.jpg', 4.03)
INSERT INTO products VALUES ('31944749', 'Hard Child', 'Natalie Shapero', 'Poetry', 11.49, 61, 'Natalie Shapero is a professor of the practice of poetry at Tufts University. Her most recent poetry collection is Hard Child (Copper Canyon, 2017), which was shortlisted for the Griffin International Poetry Prize. Her previous collection, No Object (Saturnalia, 2013), received the Great Lakes Colleges Association New Writers Award. Natalie’s writing has appeared in The New Yorker, The New York Times Magazine, Poetry, and elsewhere, and she is the recipient of a National Endowment for the Arts Fellowship, a Ruth Lilly Fellowship, and a Kenyon Review Fellowship.', 'April 11, 2017', 'Natalie Shapero’s Hard Child is a necessary companion for a world filled with ambiguity. Possessing rapid-fire comedic timing, Shapero touches on subjects such as religion, perpetual war, birth, and death—exposing humanity’s often faulty sense of what’s important and displaying a willingness to self-incriminate. These poems exhibit an expansive, searching sensibility that balks at the standard-issue hopes and fears of modern American culture.', 'hard-child.jpg', 4.17)
INSERT INTO products VALUES ('31212988', 'The Caledonian Gambit', 'Dan Moren', 'science-fiction', 11.99, 42, 'Dan Moren is the author of the supernatural detective novel All Souls Lost, as well as the popular Galactic Cold War series of sci-fi spy novels. His work has also appeared in The Boston Globe, PopSci.com, Yahoo Tech, The Magazine, Tom''s Guide, TidBITS, Six Colors, and Macworld, where he formerly worked as a senior editor.

Dan''s also a regular panelist on the Parsec-award-winning geek culture podcast , co-host of tech podcasts and , and writer and host of the nerdy game show He lives with his family in Somerville, MA, where he is never far from a twenty-sided die.', 'May 23, 2017', 'The galaxy is mired in a cold war between two superpowers, the Illyrican Empire and the Commonwealth. Thrust between this struggle are Simon Kovalic, the Commonwealth’s preeminent spy, and Kyle Rankin, a lowly soldier happily scrubbing toilets on Sabea, a remote and isolated planet. However, nothing is as it seems.

Kyle Rankin is a lie. His real name is Eli Brody, and he fled his home world of Caledonia years ago. Simon Kovalic knows Caledonia is a lit fuse hurtling towards detonation. The past Brody so desperately tried to abandon can grant him access to people and places that are off limits even to a professional spy like Kovalic.

Kovalic needs Eli Brody to come home and face his past. With Brody suddenly cast in a play he never auditioned for, he and Kovalic will quickly realize it’s everything they don’t know that will tip the scales of galactic peace. Sounds like a desperate plan, sure, but what gambit isn’t?

is a throwback to the classic sci-fi adventures of spies and off-world politics, but filled to the brim with modern sensibilities.', 'the-caledonian-gambit.jpg', 3.87)
INSERT INTO products VALUES ('33163378', 'Moxie', 'Jennifer Mathieu', 'young-adult', 2.99, 74, 'I''m a high school English teacher and writer. My novels for young people include MOXIE, THE TRUTH ABOUT ALICE, DOWN CAME THE RAIN, and more.

My fourth novel MOXIE is a film on Netflix, directed by Amy Poehler. :-)

All my YA novels are published by Roaring Brook Press/Macmillan.

In July 2024, I''ll be introducing my first novel for adults, THE FACULTY LOUNGE. It''s being published by Dutton and follows a sweeping cast of characters who all work at a big public high school in Texas.

I live in Texas with my husband, son, dog, and cat.

When it comes to what I read, I love anything that hooks me on the first page. I adore thoughtful memoirs and creative nonfiction about arts and culture. When it comes to fiction, my favorite contemporary writers are Curtis Sittenfeld, Danielle Evans, and J. Courtney Sullivan. If I could travel into the world of a book (but only for a little bit!), I''d choose an Edith Wharton novel.', 'September 19, 2017', 'Moxie girls fight back!

Vivian Carter is fed up. Fed up with her small-town Texas high school that thinks the football team can do no wrong. Fed up with sexist dress codes and hallway harassment. But most of all, Viv Carter is fed up with always following the rules.

Viv’s mom was a punk rock Riot Grrrl in the ’90s, so now Viv takes a page from her mother’s past and creates a feminist zine that she distributes anonymously to her classmates. She’s just blowing off steam, but other girls respond. Pretty soon Viv is forging friendships with other young women across the divides of cliques and popularity rankings, and she realizes that what she has started is nothing short of a girl revolution.', 'moxie.jpg', 4.20)
INSERT INTO products VALUES ('41940306', 'Lanny', 'Max Porter', 'fiction', 9.99, 85, 'Max Porter’s first novel, Grief Is the Thing with Feathers won the Sunday Times/Peter, Fraser + Dunlop Young Writer of the Year, the International Dylan Thomas Prize, the Europese Literatuurprijs and the BAMB Readers’ Award and was shortlisted for the Guardian First Book Award and the Goldsmiths Prize. It has been sold in twenty-nine territories. Complicité and Wayward’s production of Grief Is the Thing with Feathers directed by Enda Walsh and starring Cillian Murphy opened in Dublin in March 2018. Max lives in Bath with his family.', 'March 5, 2019', 'Not far from London, there is a village.

This village belongs to the people who live in it and to those who lived in it hundreds of years ago. It belongs to England''s mysterious past and its confounding present.

It belongs to families dead for generations, and to those who have only recently moved here, such as the boy Lanny, and his mum and dad.', 'lanny.jpg', 4.06)
INSERT INTO products VALUES ('38355304', 'The Line Between', 'Tosca Lee', 'Thriller', 12.99, 36, '"Superior storytelling."
-Publishers Weekly

"One of the most gifted novelists writing today."
-Steven James, bestselling author

Tosca Lee is the award-winning, New York Times, IndieBound, and Amazon bestselling author of eleven novels including THE LINE BETWEEN, A SINGLE LIGHT, THE PROGENY, THE LEGEND OF SHEBA, ISCARIOT, and the Books of Mortals series with New York Times bestseller Ted Dekker. Her work has been translated into seventeen languages and been optioned for TV and film. A notorious night-owl, she loves movies, playing football with her kids, and sending cheesy texts to her husband.

You can find Tosca at ToscaLee.com, on social media, or hanging around the snack table. To learn more, please visit toscalee.com.

For book release news and giveaways, join Tosca Lee''s Nocturnal Cafe:', 'January 29, 2019', 'An extinct disease re-emerges from the melting Alaskan permafrost to cause madness in its victims. For recent apocalyptic cult escapee Wynter Roth, it’s the end she’d always been told was coming.

When Wynter Roth is turned out of New Earth, a self-contained doomsday cult on the American prairie, she emerges into a world poised on the brink of madness as a mysterious outbreak of rapid early onset dementia spreads across the nation.

As Wynter struggles to start over in a world she’s been taught to regard as evil, she finds herself face-to-face with the apocalypse she’s feared all her life—until the night her sister shows up at her doorstep with a set of medical samples. That night, Wynter learns there’s something far more sinister at play and that these samples are key to understanding the disease.

Now, as the power grid fails and the nation descends into chaos, Wynter must find a way to get the samples to a lab in Colorado. Uncertain who to trust, she takes up with former military man Chase Miller, who has his own reasons for wanting to get close to the samples in her possession, and to Wynter herself.', 'the-line-between.jpg', 4.05)
INSERT INTO products VALUES ('41454042', 'The Summer Country', 'Lauren Willig', 'historical-fiction', 1.99, 52, 'Lauren Willig is the New York Times bestselling author of nineteen works of historical fiction. Her books have been translated into over a dozen languages, awarded the RITA, Booksellers Best and Golden Leaf awards, and chosen for the American Library Association''s annual list of the best genre fiction. After graduating from Yale University, she embarked on a PhD in History at Harvard before leaving academia to acquire a JD at Harvard Law while authoring her "Pink Carnation" series of Napoleonic-set novels. She lives in New York City, where she now writes full time.', 'June 4, 2019', 'The New York Times bestselling historical novelist delivers her biggest, boldest, and most ambitious novel yet—a sweeping, dramatic Victorian epic of lost love, lies, jealousy, and rebellion set in colonial Barbados.

1854. From Bristol to Barbados. . . .

Emily Dawson has always been the poor cousin in a prosperous merchant clan—merely a vicar’s daughter, and a reform-minded vicar’s daughter, at that. Everyone knows that the family’s lucrative shipping business will go to her cousin, Adam, one day. But when her grandfather dies, Emily receives an unexpected inheiritance: Peverills, a sugar plantation in Barbados—a plantation her grandfather never told anyone he owned.

When Emily accompanies her cousin and his new wife to Barbados, she finds Peverills a burnt-out shell, reduced to ruins in 1816, when a rising of enslaved people sent the island up in flames. Rumors swirl around the derelict plantation; people whisper of ghosts.

Why would her practical-minded grandfather leave her a property in ruins? Why are the neighboring plantation owners, the Davenants, so eager to acquire Peverills—so eager that they invite Emily and her cousins to stay with them indefinitely? Emily finds herself bewitched by the beauty of the island even as she’s drawn into the personalities and politics of forty years before: a tangled history of clandestine love, heartbreaking betrayal, and a bold bid for freedom.

When family secrets begin to unravel and the harsh truth of history becomes more and more plain, Emily must challenge everything she thought she knew about her family, their legacy . . . and herself.', 'the-summer-country.jpg', 3.86)
INSERT INTO products VALUES ('38099642', 'Holy Sister', 'Mark Lawrence', 'fantasy', 8.99, 36, 'My books vary a LOT - so here''s a handy guide.

[My new book The Book That Wouldn''t Burn is out now!]

Patreon here: https://www.patreon.com/marklawrencea...

Blog here:

I''m on now! *excitement!*


Facebook here:

Instagram


Threads


Blue Sky


Three-emails-a-year newsletter here:
#Prizes #FreeContent

I''m even on Tumblr!


Pintrest!


Plus I have free stuff on Wattpad!


Mark Lawrence is married with four children, one of whom is severely disabled. Before becoming a fulltime writer in 2015 day job was as a research scientist focused on various rather intractable problems in the field of artificial intelligence. He has held secret level clearance with both US and UK governments. At one point he was qualified to say ''this isn''t rocket science ... oh wait, it actually is''.

Mark used to have a list of hobbies back when he did science by day. Now his time is really just divided between writing and caring for his disabled daughter. There are occasional forays into computer games too.', 'April 4, 2019', 'Nona Grey''s story reaches its conclusion in the third instalment of Book of the Ancestor.

They came against her as a child. Now they face the woman.

The ice is advancing, the Corridor narrowing, and the empire is under siege from the Scithrowl in the east and the Durns in the west. Everywhere, the emperor''s armies are in retreat.

Nona faces the final challenges that must be overcome if she is to become a full sister in the order of her choice. But it seems unlikely that Nona and her friends will have time to earn a nun''s habit before war is on their doorstep.

Even a warrior like Nona cannot hope to turn the tide of war.
The shiphearts offer strength that she might use to protect those she loves, but it''s a power that corrupts. A final battle is coming in which she will be torn between friends, unable to save them all. A battle in which her own demons will try to unmake her.

A battle in which hearts will be broken, lovers lost, thrones burned.', 'holy-sister.jpg', 4.31)
INSERT INTO products VALUES ('42079209', 'Brazen and the Beast', 'Sarah MacLean', 'romance', 0.00, 0, 'New York Times, Washington Post & USA Today bestseller Sarah MacLean is the author of historical romance novels. Translated into more than twenty-five languages, the books that make up “The MacLeaniverse” are beloved by readers worldwide.

In addition to her novels, Sarah is a leading advocate for the romance genre, speaking widely on its place as a feminist text and a cultural bellwether. A columnist for the New York Times, the Washington Post and Bustle, she is the co-host of the weekly romance podcast, Fated Mates. Her work in support of romance and those who read it earned her a place on Jezebel.com''s Sheroes list and led Entertainment Weekly to call her "the elegantly fuming, utterly intoxicating queen of historical romance." She lives in New York City.', 'July 30, 2019', 'The Lady’s Plan

When Lady Henrietta Sedley declares her twenty-ninth year her own, she has plans to inherit her father’s business, to make her own fortune, and to live her own life. But first, she intends to experience a taste of the pleasure she’ll forgo as a confirmed spinster. Everything is going perfectly... until she discovers the most beautiful man she’s ever seen tied up in her carriage and threatening to ruin the Year of Hattie before it’s even begun.

The Bastard’s Proposal

When he wakes in a carriage at Hattie’s feet, Whit, a king of Covent Garden known to all the world as Beast, can’t help but wonder about the strange woman who frees him—especially when he discovers she’s headed for a night of pleasure... on his turf. He is more than happy to offer Hattie all she desires... for a price.

An Unexpected Passion

Soon, Hattie and Whit find themselves rivals in business and pleasure. She won’t give up her plans; he won’t give up his power... and neither of them sees that if they’re not careful, they’ll have no choice but to give up everything... including their hearts.', 'brazen-and-the-beast.jpg', 4.08)
INSERT INTO products VALUES ('40523931', 'The Light Brigade', 'Kameron Hurley', 'science-fiction', 7.99, 2, 'Kameron Hurley is the author of The Light Brigade, The Stars are Legion and the essay collection The Geek Feminist Revolution, as well as the award-winning God’s War Trilogy and The Worldbreaker Saga. Hurley has won the Hugo Award, Locus Award, Kitschy Award, and Sydney J. Bounds Award for Best Newcomer. She was also a finalist for the Arthur C. Clarke Award, the Nebula Award, and the Gemmell Morningstar Award. Her short fiction has appeared in Popular Science Magazine, Lightspeed and numerous anthologies. Hurley has also written for The Atlantic, Writers Digest, Entertainment Weekly, The Village Voice, LA Weekly, Bitch Magazine, and Locus Magazine. She posts regularly at KameronHurley.com. Get a short story from Kameron each month via:', 'March 19, 2019', 'The Light Brigade: it’s what soldiers fighting the war against Mars call the ones who come back…different. Grunts in the corporate corps get busted down into light to travel to and from interplanetary battlefronts. Everyone is changed by what the corps must do in order to break them down into light. Those who survive learn to stick to the mission brief—no matter what actually happens during combat.

Dietz, a fresh recruit in the infantry, begins to experience combat drops that don’t sync up with the platoon’s. And Dietz’s bad drops tell a story of the war that’s not at all what the corporate brass want the soldiers to think is going on.

Is Dietz really experiencing the war differently, or is it combat madness? Trying to untangle memory from mission brief and survive with sanity intact, Dietz is ready to become a hero—or maybe a villain; in war it’s hard to tell the difference.', 'the-light-brigade.jpg', 3.90)
INSERT INTO products VALUES ('42186023', 'Petra''s Ghost', 'C.S. O’Cinneide', 'horror', 6.99, 100, 'C.S. O''Cinneide (oh-ki-nay-da) is an Edgar nominated writer and a blogger on her website, She Kills Lit, where she features women writers of thriller and noir. Her debut novel, Petra’s Ghost, a dark thriller set on the Camino de Santiago pilgrimage, was nominated for a Goodreads Choice Award in 2019.
She is also the author of the Candace Starr crime series, which follows the hard-boiled antics of a saucy, six-foot-three hitwoman of the same name.
C.S. O''Cinneide lives in Guelph, Ontario with her husband, an Irish ex-pat who remains her constant muse.', 'July 20, 2019', 'A man''s pilgrimage becomes something from his darkest nightmares when secrets arise and ghosts haunt his path.

A woman has vanished on the Camino de Santiago, the ancient five-hundred-mile pilgrimage that crosses northern Spain. Daniel, an Irish expat, walks the lonely trail carrying his wife, Petra’s, ashes, along with the damning secret of how she really died.

When he teams up to walk with sporty California girl Ginny, she seems like the perfect antidote for his grieving heart. But a nightmare figure begins to stalk them, and his mind starts to unravel from the horror of things he cannot explain.

Unexpected twists and turns echo the path of the ancient trail they walk upon. The lines start to blur between reality and madness, between truth and the lies we tell ourselves.', 'petra-s-ghost.jpg', 3.74)
INSERT INTO products VALUES ('42046110', 'Someone Who Will Love You in All Your Damaged Glory: Stories', 'Raphael Bob-Waksberg', 'short-stories', 12.99, 31, 'Raphael Matthew Bob-Waksberg is an American comedian, writer, producer, actor, and voice actor. He is known as the creator and showrunner of the animated comedy series BoJack Horseman. He is also an executive producer on the animated series Tuca & Bertie.', 'June 11, 2019', 'A fabulously off-beat collection of short stories about love--the best and worst thing in the universe.

In "A Most Blessed and Auspicious Occasion," a young couple planning a wedding is forced to deal with interfering relatives dictating the appropriate number of ritual goat sacrifices. "Missed Connection--m4w" is the tragicomic tale of a pair of lonely commuters eternally failing to make that longed-for contact. The members of a rock band in "Up-and-Comers" discover they suddenly have superpowers--but only when they''re drunk. And in "The Serial Monogamist''s Guide to Important New York City Landmarks," a woman maps her history of romantic failures based on the places she and her significant others visited together.

Equally at home with the surreal and the painfully relatable (or both at once), Bob-Waksberg delivers a killer combination of humor, romance, whimsy, cultural commentary, and crushing emotional vulnerability. The resulting collection is a punchy, perfect bloody valentine.', 'someone-who-will-love-you-in-all-your-damaged-glory.jpg', 4.03)
INSERT INTO products VALUES ('36742978', 'Grace Will Lead Us Home: The Charleston Church Massacre and the Hard, Inspiring Journey to Forgiveness', 'Jennifer Berry Hawes', 'nonfiction', 11.99, 80, 'Jennifer Berry Hawes writes for the Charleston-based Post and Courier, where she spent a decade covering religion and now works on a team that handles in-depth investigative reporting projects for the newspaper.

Her work has won many honors including a Pulitzer Prize, a George Polk Award, a National Headliner Award, and a Dart Award for Journalism & Trauma. She lives in Charleston, S.C.', 'June 4, 2019', 'A deeply moving work of narrative nonfiction on the tragic shootings at the Mother Emanuel AME church in Charleston, South Carolina.

On June 17, 2015, twelve members of the historically black Emanuel AME Church in Charleston, South Carolina welcomed a young white man to their evening Bible study. He arrived with a pistol, 88 bullets, and hopes of starting a race war. Dylann Roof’s massacre of nine innocents during their closing prayer horrified the nation. Two days later, some relatives of the dead stood at Roof’s hearing and said, “I forgive you.” That grace offered the country a hopeful ending to an awful story. But for the survivors and victims’ families, the journey had just begun.

In , Pulitzer Prize-winning journalist Jennifer Berry Hawes provides a definitive account of the tragedy’s aftermath. With unprecedented access to the grieving families and other key figures, Hawes offers a nuanced and moving portrait of the events and emotions that emerged in the massacre’s wake.

The two adult survivors of the shooting begin to make sense of their lives again. Rifts form between some of the victims’ families and the church. A group of relatives fights to end gun violence, capturing the attention of President Obama. And a city in the Deep South must confront its racist past. This is the story of how, beyond the headlines, a community of people begins to heal.

An unforgettable and deeply human portrait of grief, faith, and forgiveness, is destined to be a classic in the finest tradition of journalism.', 'grace-will-lead-us-home.jpg', 4.46)
INSERT INTO products VALUES ('43261166', 'Wild Game: My Mother, Her Lover, and Me', 'Adrienne Brodeur', 'Memoir', 12.49, 20, 'Adrienne Brodeur is the author of the novel "Little Monsters" (forthcoming in July) and the memoir “Wild Game,” which was a Best Book of the Year by Amazon, NPR, People, and the Washington Post, and is in development as a Netflix film. She founded the literary magazine, “Zoetrope: All-Story” with filmmaker Francis Ford Coppola, was an acquiring editor at HMH Books and served as a judge for the National Book Award. Her essays have appeared in Glamour, O Magazine, The National, The New York Times, Vogue, and other publications. She is the Executive Director of the literary nonprofit, Aspen Words', 'October 15, 2019', 'A daughter’s tale of living in the thrall of her magnetic, complicated mother, and the chilling consequences of her complicity.

On a hot July night on Cape Cod when Adrienne was fourteen, her mother, Malabar, woke her at midnight with five simple words that would set the course of both of their lives for years to come: Ben Souther just kissed me. 
 
Adrienne instantly became her mother’s confidante and helpmate, blossoming in the sudden light of her attention, and from then on, Malabar came to rely on her daughter to help orchestrate what would become an epic affair with her husband’s closest friend. The affair would have calamitous consequences for everyone involved, impacting Adrienne’s life in profound ways, driving her into a precarious marriage of her own, and then into a deep depression. Only years later will she find the strength to embrace her life—and her mother—on her own terms.  

 is a brilliant, timeless memoir about how the people close to us can break our hearts simply because they have access to them, and the lies we tell in order to justify the choices we make. It’s a remarkable story of resilience, a reminder that we need not be the parents our parents were to us.', 'wild-game.jpg', 3.98)

 INSERT INTO products VALUES ('60415700', 'Now Is Not the Time to Panic', 'Kevin Wilson', 'fiction', 14.99, 56, 'Kevin Wilson is the author of two collections, Tunneling to the Center of the Earth (Ecco/Harper Perennial, 2009), which received an Alex Award from the American Library Association and the Shirley Jackson Award, and Baby You’re Gonna Be Mine (Ecco, 2018), and three novels, The Family Fang (Ecco, 2011), Perfect Little World (Ecco, 2017) and Nothing to See Here (Ecco, 2019), a New York Times bestseller and a Read with Jenna book club selection.
His new novel, Now is Not the Time to Panic, will be published by Ecco in November of 2022.
His fiction has appeared in Ploughshares, Southern Review, One Story, A Public Space, and elsewhere, and has appeared in Best American Short Stories 2020 and 2021, as well as The PEN/O. Henry Prize Stories 2012. He has received fellowships from the MacDowell Colony, Yaddo, and the KHN Center for the Arts. He lives in Sewanee, Tennessee, with his wife, the poet Leigh Anne Couch, and his sons, Griff and Patch, where he is an Associate Professor in the English Department at the University of the South.', 'November 15, 2022', 'From the New York Times bestselling author of Nothing to See Here comes an exuberant, bighearted novel about two teenage misfits who spectacularly collide one fateful summer, and the art they make that changes their lives forever.

Sixteen-year-old Frankie Budge—aspiring writer, indifferent student, offbeat loner—is determined to make it through yet another sad summer in Coalfield, Tennessee, when she meets Zeke, a talented artist who has just moved into his grandmother’s unhappy house and who is as lonely and awkward as Frankie is. Romantic and creative sparks begin to fly, and when the two jointly make an unsigned poster, shot through with an enigmatic phrase, it becomes unforgettable to anyone who sees it. The edge is a shantytown filled with gold seekers. We are fugitives, and the law is skinny with hunger for us.

The posters begin appearing everywhere, and people wonder who is behind them. Satanists, kidnappers—the rumors won’t stop, and soon the mystery has dangerous repercussions that spread far beyond the town. The art that brought Frankie and Zeke together now threatens to tear them apart.

Twenty years later, Frances Eleanor Budge—famous author, mom to a wonderful daughter, wife to a loving husband—gets a call that threatens to upend everything: a journalist named Mazzy Brower is writing a story about the Coalfield Panic of 1996. Might Frances know something about that? And will what she knows destroy the life she’s so carefully built?

A bold coming-of-age story, written with Kevin Wilson’s trademark wit and blazing prose, Now Is Not The Time to Panic is a nuanced exploration of young love, identity, and the power of art. It’s also about the secrets that haunt us—and, ultimately, what the truth will set free.', 'now-is-not-the-time-to-panic.jpg', 3.69)
INSERT INTO products VALUES ('58984701', 'More Than You''ll Ever Know', 'Katie Gutierrez', 'mystery', 0.00, 0, '', 'June 7, 2022', 'IT WAS A STORY THAT CASSIE BOWMAN COULDN''T RESIST.
LORE RIVERA LOVED TWO MEN.
UNTIL ONE OF THEM SHOT THE OTHER...

Lore Rivera was married to two men at once, until on a baking hot day in 1986, one of them found out and shot the other. A secret double life, a tragic murder. That''s the story the world knows.

It''s not the story that fascinates Cassie Bowman.

Carrying the weight of her own family tragedy, true-crime writer Cassie wants to know more about the mysterious woman at the heart of it all, Lore. How did one woman fall in love with two different men? How did she balance the love and the lies?

To her surprise, Cassie finds that Lore is willing to talk. To finally tell her heartbreaking story - about how a dance became an affair; how a marriage became a murder.

As the two women grow closer, Cassie finds she can''t help but confess her own darkest secrets. But when she slowly starts to realise that there might be more to the night of the murder than anyone has realised, can either woman face up to the thing they''ve been hiding from: the truth?', 'more-than-you-ll-ever-know.jpg', 3.73)
INSERT INTO products VALUES ('55987334', 'Four Treasures of the Sky', 'Jenny Tinghui Zhang', 'historical-fiction', 11.99, 85, 'Jenny Tinghui Zhang is a Texas-based Chinese-American writer and the author of Four Treasures of the Sky (forthcoming from Flatiron Books on April 5, 2022). She is a Kundiman fellow and graduate of the VONA/Voices and Tin House workshops. Her work has appeared in Apogee, Ninth Letter, Passages North, The Rumpus, HuffPost, The Cut, Catapult, and more.', 'April 5, 2022', 'Daiyu never wanted to be like the tragic heroine for whom she was named, revered for her beauty and cursed with heartbreak. But when she is kidnapped and smuggled across an ocean from China to America, Daiyu must relinquish the home and future she imagined for herself. Over the years that follow, she is forced to keep reinventing herself to survive. From a calligraphy school, to a San Francisco brothel, to a shop tucked into the Idaho mountains, we follow Daiyu on a desperate quest to outrun the tragedy that chases her. As anti-Chinese sentiment sweeps across the country in a wave of unimaginable violence, Daiyu must draw on each of the selves she has been—including the ones she most wants to leave behind—in order to finally claim her own name and story.

At once a literary tour de force and a groundbreaking work of historical fiction, announces Jenny Tinghui Zhang as an indelible new voice. Steeped in untold history and Chinese folklore, this novel is a spellbinding feat.', 'four-treasures-of-the-sky.jpg', 4.09)
INSERT INTO products VALUES ('58725025', 'Ordinary Monsters', 'J.M. Miro', 'fantasy', 12.99, 22, 'J.M. Miro is a novelist and poet living in the Pacific Northwest who grew up reading fantasy and speculative fiction.
He also writes under the name Steven Price.', 'June 7, 2022', 'England, 1882. In Victorian London, two children with mysterious powers are hunted by a figure of darkness —a man made of smoke.

Sixteen-year-old Charlie Ovid, despite a lifetime of brutality, doesn''t have a scar on him. His body heals itself, whether he wants it to or not. Marlowe, a foundling from a railway freight car, shines with a strange bluish light. He can melt or mend flesh. When two grizzled detectives are recruited to escort them north to safety, they are forced to confront the nature of difference, and belonging, and the shadowy edges of the monstrous.

What follows is a journey from the gaslit streets of London, to an eerie estate outside Edinburgh, where other children with gifts—the Talents—have been gathered. Here, the world of the dead and the world of the living threaten to collide. And as secrets within the Institute unfurl, Marlowe, Charlie and the rest of the Talents will discover the truth about their abilities, and the nature of the force that is stalking them: that the worst monsters sometimes come bearing the sweetest gifts.

With lush prose, mesmerizing world-building, and a gripping plot, presents a catastophic vision of the Victorian world—and of the gifted, broken children who must save it.', 'ordinary-monsters.jpg', 3.79)
INSERT INTO products VALUES ('55506996', 'The Wedding Crasher', 'Mia Sosa', 'romance', 10.99, 14, 'Mia Sosa is an award-winning and USA Today bestselling author of contemporary romance. Her books have received praise from Publishers Weekly, Kirkus Reviews, Booklist, Library Journal, The Washington Post, Buzzfeed, NPR, and more.

Booklist recently called her “the new go-to author for fans of sassy and sexy contemporary romances,” and Entertainment Weekly described her trade paperback debut, The Worst Best Man, as "rom-com perfection."

A former First Amendment and media lawyer, Mia practiced for more than a decade before trading her suits for loungewear (read: sweatpants). Now she writes fun, flirty, and moderately dirty stories about imperfect characters finding their perfect match.

Mia lives in Maryland with her husband, their two daughters, and one dog that rules them all.

For more information about Mia and her books, visit .', 'April 5, 2022', 'The USA Today bestselling author of The Worst Best Man is back with another hilarious rom-com about two strangers who get trapped in a lie and have to fake date their way out of it...

Just weeks away from ditching DC for greener pastures, Solange Pereira is roped into helping her wedding planner cousin on a random couple’s big day. It’s an easy gig... until she stumbles upon a situation that convinces her the pair isn’t meant to be. What’s a true-blue romantic to do? Crash the wedding, of course. And ensure the unsuspecting groom doesn’t make the biggest mistake of his life.

Dean Chapman had his future all mapped out. He was about to check off “start a family” and on track to “make partner” when his modern day marriage of convenience went up in smoke. Then he learns he might not land an assignment that could be his ticket to a promotion unless he has a significant other and, in a moment of panic, Dean claims to be in love with the woman who crashed his wedding. Oops.

Now Dean has a whole new item on his to-do list: beg Solange to be his pretend girlfriend. Solange feels a tiny bit bad about ruining Dean’s wedding, so she agrees to play along. Yet as they fake-date their way around town, what started as a performance for Dean’s colleagues turns into a connection that neither he nor Solange can deny. Their entire romance is a sham... there’s no way these polar opposites could fall in love for real, right?', 'the-wedding-crasher.jpg', 3.68)
INSERT INTO products VALUES ('60293362', 'Primitives', 'Erich Krauss', 'science-fiction', 9.99, 82, '', 'May 10, 2022', 'From New York Times bestselling author Erich Krauss comes Primitives, the story of two unlikely heroes thrust into a post-apocalyptic mission to restore humanity.

Thirty years after The Great Fatigue infected the globe—and the treatment regressed most of the human race to a primitive state—Seth Keller makes a gruesome discovery in his adoptive father’s makeshift lab. This revelation forces him to leave the safety of his desert home and the only other person left in the world…at least, as far as he knows.

Three thousand miles away in the jungles of Costa Rica, Sarah Peoples has made her own discovery—just as horrific, and just as life-changing. It will take her far from the fledgling colony of New Haven, yet never out of reach of its ruthless authoritarian leader.

On separate journeys a world apart, Seth and Sarah find themselves swept up in a deadly race to save humankind. Their fates will come crashing together in an epic struggle between good and evil, where the differences aren’t always clear. Among the grim realities of civilization’s demise, they discover that the remaining survivors may pose an even greater threat than the abominations they were taught to fear.

Fighting for their lives, they’re confronted with a haunting question.

Does humanity deserve to survive?

Primitives, the first book of this saga, is a tale of bravery and self-discovery found in the ruins of a dying world, where the darkest sides of human nature are revealed.', 'primitives.jpg', 3.88)
INSERT INTO products VALUES ('58652649', 'The Fervor', 'Alma Katsu', 'horror', 10.99, 96, '"Hard to put down. Not recommended reading after dark." -- Stephen King

"Makes the supernatural seem possible" -- Publishers Weekly

THE HUNGER: NPR 100 Favorite Horror Stories

THE HUNGER: Nominated for the Stoker and Locus awards

Author of THE DEEP, a reimagining of the sinking of the Titanic, and THE HUNGER, a reimagining of the Donner Party''s tragic journey (Putnam);
THE TAKER, THE RECKONING and THE DESCENT (Gallery Books). The Taker was selected by ALA/Booklist as one of the top ten debut novels of 2011.', 'April 26, 2022', 'A psychological and supernatural twist on the horrors of the Japanese American internment camps in World War II.

1944: As World War II rages on, the threat has come to the home front. In a remote corner of Idaho, Meiko Briggs and her daughter, Aiko, are desperate to return home. Following Meiko''s husband''s enlistment as an air force pilot in the Pacific months prior, Meiko and Aiko were taken from their home in Seattle and sent to one of the internment camps in the West. It didn’t matter that Aiko was American-born: They were Japanese, and therefore considered a threat by the American government.

Mother and daughter attempt to hold on to elements of their old life in the camp when a mysterious disease begins to spread among those interned. What starts as a minor cold quickly becomes spontaneous fits of violence and aggression, even death. And when a disconcerting team of doctors arrive, nearly more threatening than the illness itself, Meiko and her daughter team up with a newspaper reporter and widowed missionary to investigate, and it becomes clear to them that something more sinister is afoot, a demon from the stories of Meiko’s childhood, hell-bent on infiltrating their already strange world.

Inspired by the Japanese yokai and the jorogumo spider demon, explores a supernatural threat beyond what anyone saw coming; the danger of demonization, a mysterious contagion, and the search to stop its spread before it’s too late.', 'the-fervor.jpg', 3.63)
INSERT INTO products VALUES ('58065028', 'In On the Joke: The Original Queens of Standup Comedy', 'Shawn Levy', 'nonfiction', 14.99, 67, 'Shawn Levy is the author of eleven books of biography, pop culture history, and poetry. The former film critic of The Oregonian and KGW-TV and a former editor of American Film, he has been published in Sight and Sound, Film Comment, The New York Times, The Los Angeles Times, The Guardian, The Hollywood Reporter, and The Black Rock Beacon, among many other outlets. He jumps and claps and sings for victory in Portland, Oregon, where he serves on the board of directors of Operation Pitch Invasion.', 'April 5, 2022', 'From bestselling author Shawn Levy, a hilarious and moving account of the trailblazing women who broke down walls so they could stand before the mic.

Today, women are ascendant in stand-up comedy, even preeminent. They make headlines, fill arenas, spawn blockbuster movies. But before Amy Schumer slayed, Tiffany Haddish killed, and Ali Wong drew roars, the very idea of a female comedian seemed, to most of America, like a punch line. And it took a special sort of woman--indeed, a parade of them--to break and remake the mold.

is the story of a group of unforgettable women who knocked down the doors of stand-up comedy so other women could get a shot. It spans decades, from Moms Mabley''s rise in Black vaudeville between the world wars, to the roadhouse ribaldry of Belle Barth and Rusty Warren in the 1950s and ''60s, to Elaine May''s co-invention of improv comedy, to Joan Rivers''s and Phyllis Diller''s ferocious ascent to mainstream stardom. These women refused to be defined by type and tradition, facing down indifference, puzzlement, nay-saying, and unvarnished hostility. They were discouraged by agents, managers, audiences, critics, fellow performers--even their families. And yet they persevered against the tired notion that women couldn''t be funny, making space not only for themselves, but for the women who followed them.

Meticulously researched and irresistibly drawn, Shawn Levy''s group portrait forms a new pantheon of comedy excellence. shows how women broke into the boys'' club, offered new ideas of womanhood, and had some laughs along the way.', 'in-on-the-joke.jpg', 3.88)
-- INSERT INTO products VALUES ('59616977', 'Building a Second Brain: A Proven Method to Organize Your Digital Life and Unlock Your Creative Potential', 'Tiago Forte', 'Productivity', 14.99, 60, 'Tiago Forte is one of the world’s foremost experts on productivity and has taught thousands of people around the world how timeless principles and the latest technology can revolutionize their productivity, creativity, and personal effectiveness.

-- He has worked with organizations such as Genentech, Toyota Motor Corporation, and the Inter-American Development Bank, and appeared in a variety of publications, such as The New York Times, The Atlantic, and Harvard Business Review. Find out more at Fortelabs.com.', 'June 14, 2022', '>For the first time in history, we have instantaneous access to the world’s knowledge. There has never been a better time to learn, to contribute, and to improve ourselves. Yet, rather than feeling empowered, we are often left feeling overwhelmed by this constant influx of information. The very knowledge that was supposed to set us free has instead led to the paralyzing stress of believing we’ll never know or remember enough.

-- Now, this eye-opening and accessible guide shows how you can easily create your own personal system for knowledge management, otherwise known as a Second Brain. As a trusted and organized digital repository of your most valued ideas, notes, and creative work synced across all your devices and platforms, a Second Brain gives you the confidence to tackle your most important projects and ambitious goals.

-- Discover the full potential of your ideas and translate what you know into more powerful, more meaningful improvements in your work and life by .', 'building-a-second-brain.jpg', 4.08)
INSERT INTO products VALUES ('58438546', 'Easy Beauty', 'Chloé Cooper Jones', 'Memoir', 13.99, 92, '', 'April 5, 2022', 'From Chloé Cooper Jones—Pulitzer Prize finalist, philosophy professor, Whiting Creative Nonfiction Grant recipient—a groundbreaking memoir about disability, motherhood, and a journey to far-flung places in search of a new way of seeing and being seen.

“I am in a bar in Brooklyn, listening to two men, my friends, discuss whether my life is worth living.”

So begins Chloé Cooper Jones’s bold, revealing account of moving through the world in a body that looks different than most. Jones learned early on to factor “pain calculations” into every plan, every situation. Born with a rare congenital condition called sacral agenesis which affects both her stature and gait, her pain is physical. But there is also the pain of being judged and pitied for her appearance, of being dismissed as “less than.” The way she has been seen—or not seen—has informed her lens on the world her entire life. She resisted this reality by excelling academically and retreating to “the neutral room in her mind” until it passed. But after unexpectedly becoming a mother (in violation of unspoken social taboos about the disabled body), something in her shifts, and Jones sets off on a journey across the globe, reclaiming the spaces she’d been denied, and denied herself.

From the bars and domestic spaces of her life in Brooklyn to sculpture gardens in Rome; from film festivals in Utah to a Beyoncé concert in Milan; from a tennis tournament in California to the Killing Fields of Phnom Penh, Jones weaves memory, observation, experience, and aesthetic philosophy to probe the myths underlying our standards of beauty and desirability, and interrogates her own complicity in upholding those myths.

With its emotional depth, its prodigious, spiky intelligence, its passion and humor, is the rare memoir that has the power to make you see the world, and your place in it, with new eyes.', 'easy-beauty.jpg', 4.12)
INSERT INTO products VALUES ('60165389', 'By Hands Now Known: Jim Crow''s Legal Executioners', 'Margaret A. Burnham', 'History', 9.99, 66, '', 'September 27, 2022', 'A paradigm-shifting investigation of Jim Crow–era violence, the legal apparatus that sustained it, and its enduring legacy, from a renowned legal scholar.

If the law cannot protect a person from a lynching, then isn’t lynching the law?

In By Hands Now Known, Margaret A. Burnham, director of Northeastern University’s Civil Rights and Restorative Justice Project, challenges our understanding of the Jim Crow era by exploring the relationship between formal law and background legal norms in a series of harrowing cases from 1920 to 1960. From rendition, the legal process by which states make claims to other states for the return of their citizens, to battles over state and federal jurisdiction and the outsize role of local sheriffs in enforcing racial hierarchy, Burnham maps the criminal legal system in the mid-twentieth-century South, and traces the unremitting line from slavery to the legal structures of this period and through to today.

Drawing on an extensive database, collected over more than a decade and exceeding 1,000 cases of racial violence, she reveals the true legal system of Jim Crow, and captures the memories of those whose stories have not yet been heard.', 'by-hands-now-known.jpg', 4.32)
INSERT INTO products VALUES ('60665429', 'Thieves', 'Lucie Bryon', 'graphic-novels', 2.15, 46, 'Lucie Bryon is an cartoonist and illustrator. She studied graphic design in Orléans, France and comics at the ESA St Luc Brussels, Belgium.
She now lives in France and works for children’s publishing, video game companies and various publications as an illustrator and comic artist.
Her work has been published by ShortBox, Milan, BDkids, Kaboom Studios, Cicada Magazine, and France Inter.
She regularly publishes short comics online and self publishes books.', 'October 4, 2022', 'Ella can’t seem to remember a single thing from the party the night before at a mysterious stranger’s mansion, and she sure as heck doesn’t know why she’s woken up in her bed surrounded by a magpie’s nest of objects that aren’t her own. And she can’t stop thinking about her huge crush on Madeleine, who she definitely can’t tell about her sudden penchant for kleptomania… But does Maddy have secrets of her own? Can they piece together that night between them and fix the mess of their chaotic personal lives in time to form a normal, teenage relationship? That would be nice.', 'thieves.jpg', 4.22)
INSERT INTO products VALUES ('58984757', 'Golden Ax', 'Rio Cortez', 'Poetry', 10.99, 92, 'Rio Cortez is the New York Times bestselling author of picture books The ABCs of Black History (Workman, 2020) and The River Is My Sea (S&S, 2024). Her debut poetry collection, Golden Ax, is forthcoming from Penguin Poets this August, 2022.', 'August 30, 2022', 'From a visionary writer praised for her captivating work on Black history and experience, comes a poetry collection exploring personal, political, and artistic frontiers, journeying from her family''s history as Afropioneers in the American West to shimmering glimpses of transcendent, liberated futures.

In poems that range from wry, tongue-in-cheek observations about contemporary life to more nuanced meditations on her ancestors--some of the earliest Black pioneers to settle in the western United States after Reconstruction--Golden Ax invites readers to re-imagine the West, Black womanhood, and the legacies that shape and sustain the pursuit of freedom.', 'golden-ax.jpg', 4.04)
INSERT INTO products VALUES ('58756502', 'Jackal', 'Erin E. Adams', 'horror', 12.99, 38, 'Erin E. Adams is a first-generation Haitian American writer and theatre artist. She received her BA with honors in literary arts from Brown University, her MFA in acting from The Old Globe and University of San Diego Shiley Graduate Theatre Program, and her MFA in dramatic writing from NYU Tisch School of the Arts. An award-winning playwright and actor, Adams has called New York City home for the last decade. Jackal is her first novel.', 'October 4, 2022', 'A young Black girl goes missing in the woods outside her white Rust Belt town. But she’s not the first—and she may not be the last. . . .

It’s watching.

Liz Rocher is coming home . . . reluctantly. As a Black woman, Liz doesn’t exactly have fond memories of Johnstown, Pennsylvania, a predominantly white town. But her best friend is getting married, so she braces herself for a weekend of awkward and passive-aggressive reunions. Liz has grown, though; she can handle whatever awaits her. But on the day of the wedding, somewhere between dancing and dessert, the bride’s daughter, Caroline, goes missing—and the only thing left behind is a piece of white fabric covered in blood.



As a frantic search begins, with the police combing the trees for Caroline, Liz is the only one who notices a pattern: a summer night. A missing girl. A party in the woods. She’s seen this before. Keisha Woodson, the only other Black girl in school, walked into the woods with a mysterious man and was later found with her chest cavity ripped open and her heart missing. Liz shudders at the thought that it could have been her, and now, with Caroline missing, it can’t be a coincidence. As Liz starts to dig through the town’s history, she uncovers a horrifying secret about the place she once called home. Children have been going missing in these woods for years. All of them Black. All of them girls.



With the evil in the forest creeping closer, Liz knows what she must do: find Caroline, or be entirely consumed by the darkness.', 'jackal.jpg', 3.66)
INSERT INTO products VALUES ('58543750', 'A Show for Two', 'Tashie Bhuiyan', 'romance', 13.99, 20, 'Tashie Bhuiyan is the author of Counting Down with You, A Show for Two, and the forthcoming Stay with My Heart. She''s a New Yorker through and through, and she hopes to change the world, one book at a time. She loves writing stories about girls with wild hearts, boys who wear rings, and gaining agency through growth. When she''s not doing that, she can be found in a Chipotle or bookstore, insisting 2010 is the best year in cinematic history. (Read: Tangled and Inception.)', 'May 10, 2022', 'Mina Rahman has a plan for her future:

• Finally win the Golden Ivy student film competition,
• Get into her dream school across the country,
• Leave New York City behind once and for all,

Mina''s ticket to winning the competition falls into her lap when indie film star—and known heartbreaker—Emmitt Ramos enrolls in her high school under a secret identity to research his next role. When Mina sets out to persuade Emmitt to join her cause, he offers her a deal instead: he''ll be in her short film… she acts as a tour guide to help him with a photography contest.

As Mina ventures across the five boroughs with Emmitt by her side, the city she grew up in starts to look different and more like home than it ever has before. With the competition deadline looming, Mina''s dreams—which once seemed impenetrable—begin to crumble, and she’s forced to ask herself: Is winning worth losing everything?', 'a-show-for-two.jpg', 3.94)
INSERT INTO products VALUES ('59513138', 'Violet Made of Thorns', 'Gina Chen', 'fantasy', 10.99, 76, 'Gina Chen spent most of her life thinking she hated writing, until she churned out a few hundred thousand words of fanfiction and decided that maybe she was a writer. Her stories lean toward the fantastic, featuring heroines, antiheroines, and the kind of cleverness that brings trouble in its wake.

A self-taught artist with a degree in computer science, she generates creative nonsense in all forms of media and always has a project stewing. She has particular fondness for fairy tales, demon tales, romantic comedies, and quiz shows. Currently, she resides in Southern California, where the sunshine is as plentiful as its tea shops.', 'July 26, 2022', 'Violet is a prophet and a liar, influencing the royal court with her cleverly phrased—and not always true—divinations. Honesty is for suckers, like the oh-so-not charming Prince Cyrus, who plans to strip Violet of her official role once he’s crowned at the end of the summer—unless Violet does something about it.

But when the king asks her to falsely prophesy Cyrus’s love story for an upcoming ball, Violet awakens a dreaded curse, one that will end in either damnation or salvation for the kingdom—all depending on the prince’s choice of future bride. Violet faces her own choice: Seize an opportunity to gain control of her own destiny, no matter the cost, or give in to the ill-fated attraction that’s growing between her and Cyrus.

Violet’s wits may protect her in the cutthroat court, but they can’t change her fate. And as the boundary between hatred and love grows ever thinner with the prince, Violet must untangle a wicked web of deceit in order to save herself and the kingdom—or doom them all.', 'violet-made-of-thorns.jpg', 3.56)
INSERT INTO products VALUES ('60099657', 'How to Heal a Gryphon', 'Meg Cannistra', 'middle-grade', 7.99, 50, '', 'October 4, 2022', 'To save her family, she’ll have to make a dangerous bargain and tip the scales off balance.

With her thirteenth birthday just around the corner, Giada Bellantuono has to make a big decision: Will she join the family business and become a healer or follow her dreams? But even though she knows her calling is to heal vulnerable animals, using her powers to treat magical creatures is decidedly not allowed.

When a group of witches kidnaps her beloved older brother, Rocco, and her parents are away, Giada is the only person left who can rescue him. Swept into the magical underground city of Malavita, Giada will need the help of her new companions to save her brother—or risk losing him forever.', 'how-to-heal-a-gryphon.jpg', 3.89)