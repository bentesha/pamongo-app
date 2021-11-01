export 'package:flutter/material.dart';
export 'package:podcasts/themes/app_colors.dart';
export 'package:eva_icons_flutter/eva_icons_flutter.dart';
export 'package:ionicons/ionicons.dart';
export 'package:provider/provider.dart';
export 'package:podcasts/utils/utils.dart';
export 'package:podcasts/widgets/widgets_source.dart';
export 'package:podcasts/themes/app_icons.dart';
export 'dart:developer' show log;

import 'package:podcasts/models/series.dart';
import 'models/channel.dart';
import 'models/episode.dart';

final defaultEpisodeList = [
  const Episode(
      id: '1',
      image: firstImg,
      duration: 3650000,
      seriesName: 'Something Was Wrong',
      title: 'There Were No Red Flags',
      audioUrl: firstUrl,
      description: firstDesc,
      episodeNumber: 10,
      date: 'Jun 2'),
  const Episode(
      id: '2',
      image: secondImg,
      duration: 2965000,
      seriesName: 'Stolen: Search for Jermain',
      title: 'The Dark Horse',
      audioUrl: secondUrl,
      description: secondDesc,
      episodeNumber: 02,
      date: 'Nov 5'),
  const Episode(
      id: '3',
      image: thirdImg,
      duration: 1732000,
      seriesName: 'Business Wars',
      title: 'Introducing Who, When, WOW!',
      audioUrl: thirdUrl,
      description: thirdDesc,
      episodeNumber: 01,
      date: 'May 09'),
  const Episode(
      id: '4',
      image: fourthImg,
      duration: 732000,
      seriesName: 'Conspiracy Theories',
      title: 'Stolen Body Hypothesis',
      audioUrl: fourthUrl,
      description: fourthDesc,
      episodeNumber: 15,
      date: 'Jan 22'),
];

final seriesEpisodeList = [
  const Episode(
      id: '5',
      image: firstSeriesImage,
      duration: 185000,
      seriesName: 'The History of Christianity',
      title: 'Introducing The History of Christianity',
      audioUrl:
          'https://firebasestorage.googleapis.com/v0/b/languagetranslator-app.appspot.com/o/BadPeople-20200723-WelcomeToBadPeople.mp3?alt=media&token=cb4c6bec-915e-4408-8f6b-924e8717d262',
      description: firstSeriesEpisodeDesc,
      episodeNumber: 0,
      date: 'Jan 22 2020'),
  const Episode(
      id: '6',
      image: firstSeriesImage,
      duration: 2331000,
      seriesName: 'The History of Christianity',
      title: 'The origins of Christianity',
      audioUrl:
          'https://firebasestorage.googleapis.com/v0/b/languagetranslator-app.appspot.com/o/TheSportsDesk-20210813-MessiPSGAndFootballsPowerShift.mp3?alt=media&token=61e58913-b02c-429a-82d2-3071bcf854b4',
      description: firstSeriesEpisodeDesc,
      episodeNumber: 1,
      date: 'Jan 22 2020'),
  const Episode(
      id: '7',
      image: firstSeriesImage,
      duration: 543000,
      seriesName: 'The History of Christianity',
      title: 'The New Testament',
      audioUrl:
          'https://firebasestorage.googleapis.com/v0/b/movie-recommendation-126.appspot.com/o/RobertABelle_2021S_VO_Intro.mp3?alt=media&token=5e2aa36a-de4c-43c1-8179-76d3ae2c1af3',
      description: firstSeriesEpisodeDesc2,
      episodeNumber: 2,
      date: 'Feb 01 2020'),
  const Episode(
      id: '8',
      image: firstSeriesImage,
      duration: 968000,
      seriesName: 'The History of Christianity',
      title: 'The New Testament Part 2',
      audioUrl:
          'https://firebasestorage.googleapis.com/v0/b/movie-recommendation-126.appspot.com/o/ValorieKondosField_2019W_VO_Intro.mp3?alt=media&token=44f858fa-228b-4fba-970b-859eb7e2d973',
      description: firstSeriesEpisodeDesc3,
      episodeNumber: 3,
      date: 'Feb 05 2020'),
  const Episode(
      id: '9',
      image: firstSeriesImage,
      duration: 798000,
      seriesName: 'The History of Christianity',
      title: 'Salvation',
      audioUrl:
          'https://firebasestorage.googleapis.com/v0/b/movie-recommendation-126.appspot.com/o/NomavaZanazo_2021S_VO_Intro.mp3?alt=media&token=c22c9773-46f5-4946-8ad7-495f9a7b3253',
      description: firstSeriesEpisodeDesc4,
      episodeNumber: 4,
      date: 'Feb 12 2020'),
  const Episode(
      id: '10',
      image: firstSeriesImage,
      duration: 2469000,
      seriesName: 'The History of Christianity',
      title: 'A Theology of Atheism',
      audioUrl:
          'https://dcs.megaphone.fm/GLT5262457131.mp3?key=1365baa0ce5e90b0e8fe51b3dc57a1b2',
      description: firstSeriesEpisodeDesc,
      episodeNumber: 5,
      date: 'Feb 24 2020'),
  const Episode(
      id: '11',
      image: firstSeriesImage,
      duration: 2221000,
      seriesName: 'The History of Christianity',
      title: 'Epistle to Diogentus',
      audioUrl:
          'https://stitcher-injected.simplecastaudio.com/2768da3d-358e-4261-bb27-d13709cba3f2/episodes/d232f425-8d29-417c-b060-c3a1eb336d3c/audio/128/default.mp3/default.mp3_18940eb4d07e7952c9bc8044064b7418_35544316.mp3',
      description: firstSeriesEpisodeDesc2,
      episodeNumber: 6,
      date: 'Mar 02 2020'),
  const Episode(
      id: '12',
      image: firstSeriesImage,
      duration: 3707000,
      seriesName: 'The History of Christianity',
      title: 'Gospel of Thomas',
      audioUrl:
          'https://stitcher-injected.simplecastaudio.com/2768da3d-358e-4261-bb27-d13709cba3f2/episodes/80d3c063-483b-4a23-a183-832677af0f67/audio/128/default.mp3/default.mp3_5e8438f0f29f93d9108d688c5c455e85_59343903.mp3',
      description: firstSeriesEpisodeDesc3,
      episodeNumber: 7,
      date: 'Mar 30 2020'),
  const Episode(
      id: '13',
      image: firstSeriesImage,
      duration: 4873000,
      seriesName: 'The History of Christianity',
      title: 'The American West: Is It A Sin to be Wealthy ?',
      audioUrl:
          'https://firebasestorage.googleapis.com/v0/b/languagetranslator-app.appspot.com/o/default.mp3_ee1ec22741ef36af45ba742059ef4fe9_78003707.mp3?alt=media&token=a8599bb7-2afe-4b0a-958a-531d75426936',
      description: firstSeriesEpisodeDesc4,
      episodeNumber: 8,
      date: 'Apr 02 2020')
];

const firstUrl =
    'https://firebasestorage.googleapis.com/v0/b/movie-recommendation-126.appspot.com/o/13MinutesToTheMoon-20200610-S2Ep07Resurrection.mp3?alt=media&token=142554c0-ef21-4099-a397-3d85675d5138';
const secondUrl =
    'https://firebasestorage.googleapis.com/v0/b/movie-recommendation-126.appspot.com/o/HookedTheUnexpectedAddicts-20201007-CelebratingVisibleRecovery.mp3?alt=media&token=86e90cb5-88f0-4077-8324-46e4d40aa2c3';
const thirdUrl =
    'https://firebasestorage.googleapis.com/v0/b/movie-recommendation-126.appspot.com/o/ComedyOfTheWeek-20211018-DalisoChapondaCitizenOfNowhere.mp3?alt=media&token=775c7e00-7a29-43c2-b5b7-fbb13dbcf568';
const fourthUrl =
    'https://firebasestorage.googleapis.com/v0/b/movie-recommendation-126.appspot.com/o/StevenJohnson_2021_VO_Intro.mp3?alt=media&token=612c49f3-81bc-49a1-8732-0eaa6e0a592c';

const firstDesc =
    'A widow begins to uncover her recently deceased husband\'s disturbing secrets.';
const secondDesc =
    'The podcast takes place over the course of a single morning in a 911 dispatch call center. Call operator Joe Baylor (Gyllenhaal) tries to save a caller in grave danger-but he soon discovers that nothing is as it seems, and facing the truth is the only way out.';
const thirdDesc =
    'A psychotic oil matriarch leaves the whole industry exposed when she attempts to outfight a bullish farmer whose water has been poisoned.';
const fourthDesc =
    'A 16-year-old girl returns home from camp and learns that her mother has a new boyfriend, one she intends to marry. A man whose charm, intelligence and beauty make him look like he\'s not human at all.';

const firstImg =
    'https://images.pexels.com/photos/4278784/pexels-photo-4278784.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500';
const secondImg =
    'https://images.pexels.com/photos/5544036/pexels-photo-5544036.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500';
const thirdImg =
    'https://images.pexels.com/photos/6357186/pexels-photo-6357186.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500';
const fourthImg =
    'https://images.pexels.com/photos/7245371/pexels-photo-7245371.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500';

const firstSeriesImage =
    'https://images.pexels.com/photos/8335293/pexels-photo-8335293.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500';
const secondSeriesImage =
    'https://images.pexels.com/photos/2690323/pexels-photo-2690323.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500';
const thirdSeriesImage =
    'https://i.pinimg.com/564x/54/59/f8/5459f8ba13aa9c40dffdc31c0045f894.jpg';
const fourthSeriesImage =
    'https://images.pexels.com/photos/210600/pexels-photo-210600.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500';
const fifthSeriesImage =
    'https://images.pexels.com/photos/2738919/pexels-photo-2738919.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500';

const firstSeriesDesc = 'A history of Christian Ideas.';
const secondSeriesDesc =
    'The Cut is a weekly audio magazine exploring culture, atyle, politics and more. New episodes every wednesday.';
const thirdSeriesDesc =
    'A podcast dedicated to ideas that shape our world. In chronological order, the thinkers and ideas that forged the world we live in are broken down and explaned.';
const fourthSeriesDesc =
    'Business is war. Netflix vs. HBO, Nike vs. Adidas. Sometimes the prize is your wallet or your attention. Sometimes it\'s just the fun of beating the other guy. The outcomes of these battles shapes what we buy and how we live.\nBusiness Wars gives you real stories of what drives great companies and their leaders.';
const fifthSeriesDesc =
    'In 2018, a young mother named Tanin Charlo left a bar in Missoula, Montana, and was never seen again. After two years and thousands of hours of investigative work,  police believe they are close to solving the mystery of what happenned to her. We go inside the investigation, tracking down leads and joining search parties. As we unravel this mystery, the show examines what it means to be an indigenous woman in America.';

const firstSeriesEpisodeDesc =
    'This was the exploration of the Jewish context into which Christianity was born. In this episode, we examine the four schools of the first century Judaism and how they impacted the early church.';
const firstSeriesEpisodeDesc2 =
    'This is a brief history of the New Testament exploring both the churched traditional dating and authorship of the revisions of the Historical-Critical Method.';
const firstSeriesEpisodeDesc3 =
    'In this episaode, we explore how the New Testament came together; why some books were in, some were out, and who chose whcih was which';
const firstSeriesEpisodeDesc4 =
    'Does the concept of salvation have any use if we don\'t see it as a ticket to some other worldly existence after we die? There are a few of the questions we tackle in this raw and powerful conversation with Mason Smith.';
const channelDesc =
    'A good society is one with a proper balance between the aptitudes of ‘head’, ‘hand’ and ‘heart’. The modern knowledge economy, however, has delivered higher and higher returns to the cognitive elite and reduced the relative pay and status of manual and caring jobs.';

var defaultChannel = const Channel(
    channelDescription: channelDesc,
    channelImage:
        'https://images.pexels.com/photos/3435323/pexels-photo-3435323.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    channelName: 'The Pearson Podcast',
    channelOwner: 'Betty Pearson',
    channelSeriesList: []);
