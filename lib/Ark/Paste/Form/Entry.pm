package Ark::Paste::Form::Entry;
use Ark 'Form';

param title => (
    label => 'Title',
    type  => 'TextField',
    constraints => [
        'NOT_NULL',
        ['LENGTH', 1, 50],
    ],
    messages => {
        not_null => 'たいとる は 必須っぽい',
        length   => 'たいとる は 50文字以内でたのむ',
    },

);

param language => (
    label   => 'Language',
    type    => 'ChoiceField',
    choices => [
        bash       => 'Bash',
        cpp        => 'C++',
        csharp     => 'C#',
        css        => 'CSS',
        delphi     => 'Delphi',
        diff       => 'Diff',
        groovy     => 'Groovy',
        java       => 'Java',
        javascript => 'JavaScript',
        perl       => 'Perl',
        php        => 'PHP',
        plain      => 'Plain Text',
        python     => 'Python',
        ruby       => 'Ruby',
        scala      => 'Scala',
        sql        => 'SQL',
        vb         => 'Visual Basic',
        xml        => 'XML or HTML',
    ],
    constraints => [qw/ NOT_NULL /],
);

param content => (
    label  => 'Content',
    type   => 'TextArea',
    widget => 'textarea',
    constraints => [qw/ NOT_NULL /],
    messages => {
        not_null => 'こーど は 必須っぽい',
    },
);

1;
