There are two problems with the DB of CSES for leaders: 
1) leaders are not always the same in the DB as in the quaestionnaires 
2) missing values vary a lot btw leaders (not everyone as famous)

That is why, it is important to create indexes that controll missing values and do not need the specification of leaders (are neutral)

The ALP is going to be calculated by the mean-distance measure (Wagner 2020) which is a relative measure that takes into account all leaders or parties
It consists on the absolute average distance bt the most-liked party and the average score for all other party 
In traditional AP, the weight of each party is controlled by the % of votes this party received during last elections
It is important to create weights for leaders too, but we cannot rely on votes bc not every leader participates in the same election 

To solve this, we create a weight on the same measure (like dislike) that goes from 0 to 1, based on: 
1) the normalized level of fame (how many haven't heard of the leader / or don't know enough to respond) (for the parties, it is the share of votes from last general legislative elections). We apply the min-max normalization technique to get values bt 0 and 1) / this measure helps identifying the most important and least important leaders in a country and by giving weights from 0 to 1, it helps to control the unbalance generated by the difference between questionnaires (larger or shorter, more known or less known leaders included...)

By applying this process, we do not need the name of the leaders to understand their importance in the environment of each country and we also guarantee validity using the same data to create the weight and we control the missing values 


