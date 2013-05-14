# Example Data

validation_mode = false

# Conferences
c1 = Conference.create(
  subdomain: 'awesomeconf',
  name: 'AwesomeConf',
  email: 'rebagliatte+awesomeconf@gmail.com',
  twitter_username: 'awesomeconf',
  twitter_hashtag: 'awesomeconf',
  facebook_page_username: 'awesomeconf'
)
c2 = Conference.create(
  subdomain: 'anotherconf',
  name: 'AnotherConf',
  email: 'rebagliatte+anotherconf@gmail.com',
  twitter_username: 'anotherconf',
  twitter_hashtag: 'anotherconf',
  facebook_page_username: 'anotherconf'
)

# Conference Editions
ce1 = ConferenceEdition.create(
    status: 'live',
    from_date: Date.today,
    to_date: Date.tomorrow,
    tagline: 'The most awesome conference ever',
    country: 'Uruguay',
    city: 'Montevideo',
    venue: 'Auditorium A',
    kind: 'single_track',
    promo_video_provider: 'youtube',
    promo_video_uid: 'FCZs6Ijnyx8',
    conference: c1
  )
ce2 = ConferenceEdition.create(
    status: 'past',
    from_date: Date.today - 1.year,
    to_date: Date.tomorrow - 1.years,
    tagline: 'A previous conference',
    country: 'Uruguay',
    city: 'Montevideo',
    venue: 'Auditorium A',
    kind: 'single_track',
    promo_video_provider: 'vimeo',
    promo_video_uid: '62132088',
    conference: c1
  )
ce3 = ConferenceEdition.create(
    status: 'past',
    from_date: Date.today - 2.year,
    to_date: Date.tomorrow - 2.years,
    tagline: 'Another previous conference',
    country: 'Uruguay',
    city: 'Montevideo',
    venue: 'Auditorium A',
    kind: 'single_track',
    conference: c1
  )

# Slots
slot1 = Slot.create(
    from_datetime: Date.today + 1.hour,
    to_datetime: Date.today + 2.hours,
    kind: 'talk',
    conference_edition: ce1
  )
slot2 = Slot.create(
    from_datetime: Date.today + 2.hours,
    to_datetime: Date.today + 3.hours,
    kind: 'break',
    conference_edition: ce1
  )
slot3 = Slot.create(
    from_datetime: Date.today + 3.hours,
    to_datetime: Date.today + 4.hours,
    kind: 'talk',
    conference_edition: ce1
  )
slot4 = Slot.create(
    from_datetime: Date.tomorrow + 1.hour,
    to_datetime: Date.tomorrow + 2.hours,
    kind: 'talk',
    conference_edition: ce1
  )

# Slots for ce2
slot5 = Slot.create(
    from_datetime: Date.today + 1.hour - 1.year,
    to_datetime: Date.today + 2.hours - 1.year,
    kind: 'talk',
    conference_edition: ce2
  )
slot6 = Slot.create(
    from_datetime: Date.today + 2.hours - 1.year,
    to_datetime: Date.today + 3.hours - 1.year,
    kind: 'talk',
    conference_edition: ce2
  )

# Rooms
room1 = Room.create(
    name: 'Room 1'
  )
room2 = Room.create(
    name: 'Room 2'
  )

# Talks
talk1 = Talk.create(
    title: 'Talk 1',
    abstract: 'A nice talk',
    status: 'approved',
    slot: slot1,
    room: room1
  )
talk2 = Talk.create(
    title: 'Talk 2',
    abstract: 'Another nice talk',
    status: 'approved',
    slot: slot3,
    room: room1
  )
talk3 = Talk.create(
    title: 'Talk 3',
    abstract: 'Another nice talk',
    status: 'approved',
    slot: slot4,
    room: room1
  )
talk4 = Talk.create(
    title: 'Talk 4',
    abstract: 'Not so nice talk',
    status: 'rejected',
    slot: nil,
    room: nil
  )
# Talks for ce2
talk5 = Talk.create(
    title: 'Talk 5, given in 2011 edition',
    abstract: 'A nice talk',
    status: 'approved',
    slot: slot5,
    room: room1
  )
talk6 = Talk.create(
    title: 'Talk 6 , given in 2011 edition',
    abstract: 'Another nice talk',
    status: 'approved',
    slot: slot6,
    room: room1
  )

# Speakers
Speaker.new(
    name: 'Vero Rebagliatte',
    company: 'Company A',
    city: 'Montevideo',
    country: 'Uruguay',
    bio: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut ac magna ipsum. Phasellus vitae tempus ligula. Nullam id nisl vel metus commodo sagittis.
    Phasellus elit mauris, tincidunt id viverra vitae, fermentum vel metus. Nunc varius magna bibendum tortor vehicula imperdiet.
    Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Nulla id metus lorem. Praesent malesuada posuere lectus nec semper. Aliquam quis euismod ante. Proin mattis aliquam massa eget mollis. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Nulla faucibus turpis ac justo pretium placerat. Nunc sit amet felis nisl, vel iaculis lorem. Curabitur aliquet feugiat tincidunt. Nunc lobortis placerat ante, at faucibus sapien euismod ut. Aenean auctor lacus ac velit tristique semper.",
    twitter_username: 'rebagliatte',
    github_username: 'rebagliatte',
    email: 'veronica@rebagliatte.com',
    talks: [talk1]
).save(validate: validation_mode)

Speaker.new(
    name: 'John Smith',
    company: 'Company B',
    city: 'Chicago',
    country: 'USA',
    bio: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut ac magna ipsum. Phasellus vitae tempus ligula. Nullam id nisl vel metus commodo sagittis.
    Phasellus elit mauris, tincidunt id viverra vitae, fermentum vel metus. Nunc varius magna bibendum tortor vehicula imperdiet.
    Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Nulla id metus lorem. Praesent malesuada posuere lectus nec semper. Aliquam quis euismod ante. Proin mattis aliquam massa eget mollis. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Nulla faucibus turpis ac justo pretium placerat. Nunc sit amet felis nisl, vel iaculis lorem. Curabitur aliquet feugiat tincidunt. Nunc lobortis placerat ante, at faucibus sapien euismod ut. Aenean auctor lacus ac velit tristique semper.",
    twitter_username: 'johnsmith',
    github_username: 'johnsmith',
    email: 'rebagliatte+johnsmith@gmail.com',
    talks: [talk2]
).save(validate: validation_mode)

Speaker.new(
    name: 'Peter Jones',
    company: 'Company C',
    city: 'Brasilia',
    country: 'Brazil',
    bio: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut ac magna ipsum. Phasellus vitae tempus ligula. Nullam id nisl vel metus commodo sagittis.
    Phasellus elit mauris, tincidunt id viverra vitae, fermentum vel metus. Nunc varius magna bibendum tortor vehicula imperdiet.
    Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Nulla id metus lorem. Praesent malesuada posuere lectus nec semper. Aliquam quis euismod ante. Proin mattis aliquam massa eget mollis. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Nulla faucibus turpis ac justo pretium placerat. Nunc sit amet felis nisl, vel iaculis lorem. Curabitur aliquet feugiat tincidunt. Nunc lobortis placerat ante, at faucibus sapien euismod ut. Aenean auctor lacus ac velit tristique semper.",
    twitter_username: 'peterjones',
    github_username: 'peterjones',
    email: 'rebagliatte+peterjones@gmail.com',
    talks: [talk3]
).save(validate: validation_mode)

Speaker.new(
    name: 'John Perkins',
    company: 'Company C',
    city: 'NY',
    country: 'USA',
    bio: "**Rejected speaker** Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut ac magna ipsum. Phasellus vitae tempus ligula. Nullam id nisl vel metus commodo sagittis.
    Phasellus elit mauris, tincidunt id viverra vitae, fermentum vel metus. Nunc varius magna bibendum tortor vehicula imperdiet.
    Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Nulla id metus lorem. Praesent malesuada posuere lectus nec semper. Aliquam quis euismod ante. Proin mattis aliquam massa eget mollis. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Nulla faucibus turpis ac justo pretium placerat. Nunc sit amet felis nisl, vel iaculis lorem. Curabitur aliquet feugiat tincidunt. Nunc lobortis placerat ante, at faucibus sapien euismod ut. Aenean auctor lacus ac velit tristique semper.",
    twitter_username: 'johnperkins',
    github_username: 'johnperkins',
    email: 'rebagliatte+johnperkins@gmail.com',
    talks: [talk4]
).save(validate: validation_mode)

Speaker.new(
    name: 'Peter Parker',
    company: 'Company C',
    city: 'Brasilia',
    country: 'Brazil',
    bio: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut ac magna ipsum. Phasellus vitae tempus ligula. Nullam id nisl vel metus commodo sagittis.
    Phasellus elit mauris, tincidunt id viverra vitae, fermentum vel metus. Nunc varius magna bibendum tortor vehicula imperdiet.
    Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Nulla id metus lorem. Praesent malesuada posuere lectus nec semper. Aliquam quis euismod ante. Proin mattis aliquam massa eget mollis. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Nulla faucibus turpis ac justo pretium placerat. Nunc sit amet felis nisl, vel iaculis lorem. Curabitur aliquet feugiat tincidunt. Nunc lobortis placerat ante, at faucibus sapien euismod ut. Aenean auctor lacus ac velit tristique semper.",
    twitter_username: 'peterparker',
    github_username: 'peterparker',
    email: 'rebagliatte+peterparker@gmail.com',
    talks: [talk5]
).save(validate: validation_mode)

Speaker.new(
    name: 'Peter Peters',
    company: 'Company C',
    city: 'Brasilia',
    country: 'Brazil',
    bio: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut ac magna ipsum. Phasellus vitae tempus ligula. Nullam id nisl vel metus commodo sagittis.
    Phasellus elit mauris, tincidunt id viverra vitae, fermentum vel metus. Nunc varius magna bibendum tortor vehicula imperdiet.
    Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Nulla id metus lorem. Praesent malesuada posuere lectus nec semper. Aliquam quis euismod ante. Proin mattis aliquam massa eget mollis. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Nulla faucibus turpis ac justo pretium placerat. Nunc sit amet felis nisl, vel iaculis lorem. Curabitur aliquet feugiat tincidunt. Nunc lobortis placerat ante, at faucibus sapien euismod ut. Aenean auctor lacus ac velit tristique semper.",
    twitter_username: 'peterpeters',
    github_username: 'peterpeters',
    email: 'rebagliatte+peterpeters@gmail.com',
    talks: [talk6]
).save(validate: validation_mode)

# Sponsors
Sponsor.new(
    name: 'Company 1',
    description: 'A sponsor',
    kind: 'platinum',
    conference_edition: ce1,
    website_url: 'http://rebagliatte.com'
).save(validate: validation_mode)

Sponsor.new(
    name: 'Company 2',
    description: 'A sponsor',
    kind: 'gold',
    conference_edition: ce1,
    website_url: 'http://rebagliatte.com'
).save(validate: validation_mode)

Sponsor.new(
    name: 'Company 3',
    description: 'A sponsor',
    kind: 'silver',
    conference_edition: ce1,
    website_url: 'http://rebagliatte.com'
).save(validate: validation_mode)

Sponsor.new(
    name: 'Company 4',
    description: 'A sponsor',
    kind: 'silver',
    conference_edition: ce1,
    website_url: 'http://rebagliatte.com'
).save(validate: validation_mode)

Sponsor.new(
    name: 'Company 5',
    description: 'A sponsor',
    kind: 'gold',
    conference_edition: ce2,
    website_url: 'http://rebagliatte.com'
).save(validate: validation_mode)


# Posts
Post.create([{
    title: 'Post 1',
    body: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum mollis, arcu luctus dapibus faucibus, felis magna elementum felis, eget imperdiet diam neque in elit. Fusce sagittis sagittis turpis eu pellentesque. Integer dignissim enim sed urna imperdiet egestas lacinia urna tincidunt.',
    summary: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    conference_edition: ce1
},{
    title: 'Post 2',
    body: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum mollis, arcu luctus dapibus faucibus, felis magna elementum felis, eget imperdiet diam neque in elit. Fusce sagittis sagittis turpis eu pellentesque. Integer dignissim enim sed urna imperdiet egestas lacinia urna tincidunt.',
    summary: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    conference_edition: ce1
},{
    title: 'Post 3',
    body: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum mollis, arcu luctus dapibus faucibus, felis magna elementum felis, eget imperdiet diam neque in elit. Fusce sagittis sagittis turpis eu pellentesque. Integer dignissim enim sed urna imperdiet egestas lacinia urna tincidunt.',
    summary: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    conference_edition: ce1
},{
    title: 'Post 4',
    body: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum mollis, arcu luctus dapibus faucibus, felis magna elementum felis, eget imperdiet diam neque in elit. Fusce sagittis sagittis turpis eu pellentesque. Integer dignissim enim sed urna imperdiet egestas lacinia urna tincidunt.',
    summary: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    conference_edition: ce1
},{
    title: 'Post 5, belonging to a previous conference',
    body: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum mollis, arcu luctus dapibus faucibus, felis magna elementum felis, eget imperdiet diam neque in elit. Fusce sagittis sagittis turpis eu pellentesque. Integer dignissim enim sed urna imperdiet egestas lacinia urna tincidunt.',
    summary: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    conference_edition: ce2
}])
