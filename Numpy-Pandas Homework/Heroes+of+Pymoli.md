

```python
#Three Observable Trends
#Players that are between ages 20-24 purchased the most amount of items.
#The Most Popular Items were Betrayal,Whisper of Grieving Widows and Arcane Gem but the most profitable item 
#was the Retribution Axe.
#Most players were male.
```


```python
#state dependencies 
import pandas as pd
import numpy as np
```


```python
#declare file path
file_path="Resources/purchase_data.json"
#import file as dataframe
Heroes_df=pd.read_json(file_path)


```


```python
#Total number of players 
total=Heroes_df["SN"].count()
total_df=pd.DataFrame({"Total Number of Players":[total]})
total_df.head()

```




<div>
<style>
    .dataframe thead tr:only-child th {
        text-align: right;
    }

    .dataframe thead th {
        text-align: left;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Total Number of Players</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>780</td>
    </tr>
  </tbody>
</table>
</div>




```python
#Purchasing Analysis(Total)

#Number of Unique Items
unique_items=Heroes_df["Item Name"].unique()
number_of_unique_items=len(unique_items)

#Average Purchase Price
aver_purchase_price=Heroes_df["Price"].mean()

#Total Number of Purchases
number_of_purchases=Heroes_df["Price"].count()

#Total Revenue
total_revenue=Heroes_df["Price"].sum()

#Putting these aspects into a new DataFrame
purchasing_analysis_total_df=pd.DataFrame({"Number of Unique Items":[number_of_unique_items],
                                        "Average Purchase Price":[aver_purchase_price],
                                        "Total Number of Purchases":[number_of_purchases],
                                        "Total Revenue":[total_revenue]})
purchasing_analysis_total_df.head()
```




<div>
<style>
    .dataframe thead tr:only-child th {
        text-align: right;
    }

    .dataframe thead th {
        text-align: left;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Average Purchase Price</th>
      <th>Number of Unique Items</th>
      <th>Total Number of Purchases</th>
      <th>Total Revenue</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>2.931192</td>
      <td>179</td>
      <td>780</td>
      <td>2286.33</td>
    </tr>
  </tbody>
</table>
</div>




```python
#Gender Demographics

#Percentage and Count of Male Players

male_players=Heroes_df.loc[Heroes_df["Gender"] == "Male",:]
num_of_male_players=male_players["Gender"].count()

percent_of_male_players=(num_of_male_players/total)*100


#Percentage and Count of Female Players

female_players=Heroes_df.loc[Heroes_df["Gender"] == "Female",:]
num_of_female_players=female_players["Gender"].count()

percent_of_female_players=(num_of_female_players/total)*100


#Percentage and Count of Other/Non-Disclosed

other_players=Heroes_df.loc[Heroes_df["Gender"] == "Other / Non-Disclosed",:]
num_of_other_players=other_players["Gender"].count()

percent_of_other_players=(num_of_other_players/total)*100



#organizing the dataframe
gender_demo_df=pd.DataFrame({"Gender":["Male","Female","Other/Nondisclosed"],
                                        "Total Count":[num_of_male_players,num_of_female_players,num_of_other_players],
                                        "Percentage of Players":[percent_of_male_players,percent_of_female_players,percent_of_other_players]
                                       })

gender_demo_group=gender_demo_df.set_index('Gender')
gender_demo_group.head()
```




<div>
<style>
    .dataframe thead tr:only-child th {
        text-align: right;
    }

    .dataframe thead th {
        text-align: left;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Percentage of Players</th>
      <th>Total Count</th>
    </tr>
    <tr>
      <th>Gender</th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>Male</th>
      <td>81.153846</td>
      <td>633</td>
    </tr>
    <tr>
      <th>Female</th>
      <td>17.435897</td>
      <td>136</td>
    </tr>
    <tr>
      <th>Other/Nondisclosed</th>
      <td>1.410256</td>
      <td>11</td>
    </tr>
  </tbody>
</table>
</div>




```python
#Purchasing Analysis(Gender)
#Purchase Counts for Each Gender
#Purchase Count of Males
gender_index=Heroes_df.set_index("Gender")
male_price_df=gender_index.loc[["Male"],["Price"]]
purchase_count_males=male_price_df["Price"].count()

#Purchase Count of Females
female_price_df=gender_index.loc[["Female"],["Price"]]
purchase_count_females=female_price_df["Price"].count()

#Purchase Count of Other
other_price_df=gender_index.loc[["Other / Non-Disclosed"],["Price"]]
purchase_count_other=other_price_df["Price"].count()

#Average Purchase Price
#Average Purchase Price of Males
avg_purchase_male=male_price_df["Price"].mean()

#Average Purchase Price of Females
avg_purchase_female=female_price_df["Price"].mean()

#Average Purchase Price of Other/Non-Disclosed
avg_purchase_other=other_price_df["Price"].mean()

#Total Purchase Value
#Total Purchase Value For Males
total_purchase_male=male_price_df["Price"].sum()

#Total Purchase Value For Females
total_purchase_female=female_price_df["Price"].sum()

#Total Purchase Value For Other/Non-Disclosed
total_purchase_other=other_price_df["Price"].sum()

#Normalized Totals
#Normalized Total for Males
std_dev_male=male_price_df["Price"].std()
norm_total_male=abs(((total_purchase_male-avg_purchase_male))/(std_dev_male))

#Normalized Total for Females
std_dev_female=female_price_df["Price"].std()
norm_total_female=abs(((total_purchase_female-avg_purchase_female))/(std_dev_female))
#Normalized Total for Other/Non-Disclosed
std_dev_other=other_price_df["Price"].std()
norm_total_other=abs(((total_purchase_other-avg_purchase_other))/(std_dev_other))


#organizing a dataframe
purchasing_analysis_gender=pd.DataFrame({"Gender":["Male","Female","Other/Nondisclosed"],
                                            "Purchase Count":[purchase_count_males,purchase_count_females,purchase_count_other],
                                            "Average Purchase Price":[avg_purchase_male,avg_purchase_female,avg_purchase_other],
                                            "Total Purchase Value":[total_purchase_male,total_purchase_female,total_purchase_other],
                                            "Normalized Totals":[norm_total_male,norm_total_female,norm_total_other]
                                           })
purchasing_analysis_gender_group=purchasing_analysis_gender.set_index('Gender')

purchasing_analysis_gender_group.head()
            


```




<div>
<style>
    .dataframe thead tr:only-child th {
        text-align: right;
    }

    .dataframe thead th {
        text-align: left;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Average Purchase Price</th>
      <th>Normalized Totals</th>
      <th>Purchase Count</th>
      <th>Total Purchase Value</th>
    </tr>
    <tr>
      <th>Gender</th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>Male</th>
      <td>2.950521</td>
      <td>1679.987030</td>
      <td>633</td>
      <td>1867.68</td>
    </tr>
    <tr>
      <th>Female</th>
      <td>2.815515</td>
      <td>330.222006</td>
      <td>136</td>
      <td>382.91</td>
    </tr>
    <tr>
      <th>Other/Nondisclosed</th>
      <td>3.249091</td>
      <td>33.942639</td>
      <td>11</td>
      <td>35.74</td>
    </tr>
  </tbody>
</table>
</div>




```python
#Age Demographics
age_bins=[0,10,14,19,24,29,34,39,100]
age_labels=['<10','10-14','15-19','20-24','25-29','30-34','35-39','40+']
Heroes_df["Age Group"]=pd.cut(Heroes_df["Age"],age_bins, labels=age_labels)
age_group_index=Heroes_df.set_index('Age Group')

#Purchase Counts for each group
binone_df=age_group_index.loc[["<10"],["Price"]]
purchase_countbinone=binone_df["Price"].count()

bintwo_df=age_group_index.loc[["10-14"],["Price"]]
purchase_countbintwo=bintwo_df["Price"].count()

binthree_df=age_group_index.loc[["15-19"],["Price"]]
purchase_countbinthree=binthree_df["Price"].count()

binfour_df=age_group_index.loc[["20-24"],["Price"]]
purchase_countbinfour=binfour_df["Price"].count()

binfive_df=age_group_index.loc[["25-29"],["Price"]]
purchase_countbinfive=binfive_df["Price"].count()

binsix_df=age_group_index.loc[["30-34"],["Price"]]
purchase_countbinsix=binsix_df["Price"].count()

binseven_df=age_group_index.loc[["35-39"],["Price"]]
purchase_countbinseven=binseven_df["Price"].count()

bineight_df=age_group_index.loc[["40+"],["Price"]]
purchase_countbineight=bineight_df["Price"].count()


#Average Purchase Price for each group
avg_purchase_binone=binone_df["Price"].mean()

avg_purchase_bintwo=bintwo_df["Price"].mean()

avg_purchase_binthree=binthree_df["Price"].mean()

avg_purchase_binfour=binfour_df["Price"].mean()

avg_purchase_binfive=binfive_df["Price"].mean()

avg_purchase_binsix=binsix_df["Price"].mean()

avg_purchase_binseven=binseven_df["Price"].mean()

avg_purchase_bineight=bineight_df["Price"].mean()


#Total Purchase Value
totalpurchasebinone=binone_df["Price"].sum()

totalpurchasebintwo=bintwo_df["Price"].sum()

totalpurchasebinthree=binthree_df["Price"].sum()

totalpurchasebinfour=binfour_df["Price"].sum()

totalpurchasebinfive=binfive_df["Price"].sum()

totalpurchasebinsix=binsix_df["Price"].sum()

totalpurchasebinseven=binseven_df["Price"].sum()

totalpurchasebineight=bineight_df["Price"].sum()


#Normalized Totals
std_devbinone=binone_df["Price"].std()
norm_totalbinone=abs(((totalpurchasebinone-avg_purchase_binone))/(std_devbinone))

std_devbintwo=bintwo_df["Price"].std()
norm_totalbintwo=abs(((totalpurchasebintwo-avg_purchase_bintwo))/(std_devbintwo))

std_devbinthree=binthree_df["Price"].std()
norm_totalbinthree=abs(((totalpurchasebinthree-avg_purchase_binthree))/(std_devbinthree))

std_devbinfour=binfour_df["Price"].std()
norm_totalbinfour=abs(((totalpurchasebinfour-avg_purchase_binfour))/(std_devbinfour))

std_devbinfive=binfive_df["Price"].std()
norm_totalbinfive=abs(((totalpurchasebinfive-avg_purchase_binfive))/(std_devbinfive))

std_devbinsix=binsix_df["Price"].std()
norm_totalbinsix=abs(((totalpurchasebinsix-avg_purchase_binsix))/(std_devbinsix))

std_devbinseven=binseven_df["Price"].std()
norm_totalbinseven=abs(((totalpurchasebinseven-avg_purchase_binseven))/(std_devbinseven))

std_devbineight=bineight_df["Price"].std()
norm_totalbineight=abs(((totalpurchasebineight-avg_purchase_bineight))/(std_devbineight))

#finally organizing a dataframe
age_demographics_df=pd.DataFrame({"Age Groups":['<10','10-14','15-19','20-24','25-29','30-34','35-39','40+'],
                                  "Purchase Count":[purchase_countbinone,purchase_countbintwo,purchase_countbinthree,purchase_countbinfour,purchase_countbinfive,purchase_countbinsix,purchase_countbinseven,purchase_countbineight],
                                  "Average Purchase Price":[avg_purchase_binone,avg_purchase_bintwo,avg_purchase_binthree,avg_purchase_binfour,avg_purchase_binfive,avg_purchase_binsix,avg_purchase_binseven,avg_purchase_bineight],
                                  "Total Purchase":[totalpurchasebinone,totalpurchasebintwo,totalpurchasebinthree,totalpurchasebinfour,totalpurchasebinfive,totalpurchasebinsix,totalpurchasebinseven,totalpurchasebineight],
                                  "Normalized Totals":[norm_totalbinone,norm_totalbintwo,norm_totalbinthree,norm_totalbinfour,norm_totalbinfive,norm_totalbinsix,norm_totalbinseven,norm_totalbineight]
                                 })
age_demographics_group=age_demographics_df.set_index("Age Groups")
age_demographics_group.head()
```




<div>
<style>
    .dataframe thead tr:only-child th {
        text-align: right;
    }

    .dataframe thead th {
        text-align: left;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Average Purchase Price</th>
      <th>Normalized Totals</th>
      <th>Purchase Count</th>
      <th>Total Purchase</th>
    </tr>
    <tr>
      <th>Age Groups</th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>&lt;10</th>
      <td>3.019375</td>
      <td>80.787100</td>
      <td>32</td>
      <td>96.62</td>
    </tr>
    <tr>
      <th>10-14</th>
      <td>2.702903</td>
      <td>76.971819</td>
      <td>31</td>
      <td>83.79</td>
    </tr>
    <tr>
      <th>15-19</th>
      <td>2.905414</td>
      <td>342.115295</td>
      <td>133</td>
      <td>386.42</td>
    </tr>
    <tr>
      <th>20-24</th>
      <td>2.913006</td>
      <td>877.080674</td>
      <td>336</td>
      <td>978.77</td>
    </tr>
    <tr>
      <th>25-29</th>
      <td>2.962640</td>
      <td>322.047667</td>
      <td>125</td>
      <td>370.33</td>
    </tr>
  </tbody>
</table>
</div>




```python
#Top Spenders

#group by the SN
group_by_SN=Heroes_df.groupby("SN")
#reset indexes for sorting afterwards
totalprice=group_by_SN["Price"].sum().reset_index()
average_price=group_by_SN["Price"].mean().reset_index()
purchasecount=group_by_SN["Price"].count().reset_index()
#merge purchase count data and average price data
merge=pd.merge(average_price,purchasecount,on="SN")
#merge everything together
totalpricemerge=pd.merge(totalprice,merge,on="SN")
#sort the values by total price
highest_purchases=totalpricemerge.sort_values("Price",ascending=False)
#locates the top five total purchases
topfive=highest_purchases.iloc[0:5,:]
#rename the columns of the merge
top_five=topfive.rename(index=str, columns={'SN':'SN','Price':'Total Purchase Value','Price_x':'Average Purchase Price','Price_y':'Purchase Count'})
#set the SN as an index
top_spenders=top_five.set_index('SN')
top_spenders

```




<div>
<style>
    .dataframe thead tr:only-child th {
        text-align: right;
    }

    .dataframe thead th {
        text-align: left;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Total Purchase Value</th>
      <th>Average Purchase Price</th>
      <th>Purchase Count</th>
    </tr>
    <tr>
      <th>SN</th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>Undirrala66</th>
      <td>17.06</td>
      <td>3.412000</td>
      <td>5</td>
    </tr>
    <tr>
      <th>Saedue76</th>
      <td>13.56</td>
      <td>3.390000</td>
      <td>4</td>
    </tr>
    <tr>
      <th>Mindimnya67</th>
      <td>12.74</td>
      <td>3.185000</td>
      <td>4</td>
    </tr>
    <tr>
      <th>Haellysu29</th>
      <td>12.73</td>
      <td>4.243333</td>
      <td>3</td>
    </tr>
    <tr>
      <th>Eoda93</th>
      <td>11.58</td>
      <td>3.860000</td>
      <td>3</td>
    </tr>
  </tbody>
</table>
</div>




```python
#Most Popular Items
#group by Item ID and Item Name
group_by_items=Heroes_df.groupby(["Item ID","Item Name"])
#reset the indexes for sorting
purchase_count=group_by_items["Price"].count().reset_index()
item_price=group_by_items["Price"].min().reset_index()
total_purchase_value=group_by_items["Price"].sum().reset_index()
#merge item price and total purchase value data
merge=pd.merge(item_price,total_purchase_value, on=["Item ID","Item Name"])
#merge everything together
purchase_count_merge=pd.merge(purchase_count,merge,on=["Item ID","Item Name"])
#sort the values by purchase count
highest_purchase_counts=purchase_count_merge.sort_values("Price",ascending=False)
#locates the top five purchase counts
topfive=highest_purchase_counts.iloc[0:5,:]
#rename the columns
top_five=topfive.rename(index=str,columns={"Item ID":"Item ID","Item Name":"Item Name","Price":"Purchase Count","Price_x":"Item Price","Price_y":"Total Purchase Value"})
#set Item ID and Item Name as indices
most_popular_items=top_five.set_index(["Item ID","Item Name"])
most_popular_items
```




<div>
<style>
    .dataframe thead tr:only-child th {
        text-align: right;
    }

    .dataframe thead th {
        text-align: left;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th></th>
      <th>Purchase Count</th>
      <th>Item Price</th>
      <th>Total Purchase Value</th>
    </tr>
    <tr>
      <th>Item ID</th>
      <th>Item Name</th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>39</th>
      <th>Betrayal, Whisper of Grieving Widows</th>
      <td>11</td>
      <td>2.35</td>
      <td>25.85</td>
    </tr>
    <tr>
      <th>84</th>
      <th>Arcane Gem</th>
      <td>11</td>
      <td>2.23</td>
      <td>24.53</td>
    </tr>
    <tr>
      <th>31</th>
      <th>Trickster</th>
      <td>9</td>
      <td>2.07</td>
      <td>18.63</td>
    </tr>
    <tr>
      <th>175</th>
      <th>Woeful Adamantite Claymore</th>
      <td>9</td>
      <td>1.24</td>
      <td>11.16</td>
    </tr>
    <tr>
      <th>13</th>
      <th>Serenity</th>
      <td>9</td>
      <td>1.49</td>
      <td>13.41</td>
    </tr>
  </tbody>
</table>
</div>




```python
#Most Profitable Items
#merge item price and purchase count together
merge=pd.merge(purchase_count,item_price,on=["Item ID","Item Name"])
#merge everything together
total_purchase_value_merge=pd.merge(total_purchase_value,merge,on=["Item ID","Item Name"])
#sort by highest total purchase values
highest_total=total_purchase_value_merge.sort_values("Price",ascending=False)
#locate the top five highest total purchase values
topfive=highest_total.iloc[0:5,:]
#rename columns
top_five=topfive.rename(index=str,columns={"Item ID":"Item ID","Item Name":"Item Name","Price":"Total Purchase Value","Price_x":"Purchase Count","Price_y":"Item Price"})
#set Item ID and Item Name as indices
most_profitable_items=top_five.set_index(["Item ID","Item Name"])
most_profitable_items
```




<div>
<style>
    .dataframe thead tr:only-child th {
        text-align: right;
    }

    .dataframe thead th {
        text-align: left;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th></th>
      <th>Total Purchase Value</th>
      <th>Purchase Count</th>
      <th>Item Price</th>
    </tr>
    <tr>
      <th>Item ID</th>
      <th>Item Name</th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>34</th>
      <th>Retribution Axe</th>
      <td>37.26</td>
      <td>9</td>
      <td>4.14</td>
    </tr>
    <tr>
      <th>115</th>
      <th>Spectral Diamond Doomblade</th>
      <td>29.75</td>
      <td>7</td>
      <td>4.25</td>
    </tr>
    <tr>
      <th>32</th>
      <th>Orenmir</th>
      <td>29.70</td>
      <td>6</td>
      <td>4.95</td>
    </tr>
    <tr>
      <th>103</th>
      <th>Singed Scalpel</th>
      <td>29.22</td>
      <td>6</td>
      <td>4.87</td>
    </tr>
    <tr>
      <th>107</th>
      <th>Splitter, Foe Of Subtlety</th>
      <td>28.88</td>
      <td>8</td>
      <td>3.61</td>
    </tr>
  </tbody>
</table>
</div>


